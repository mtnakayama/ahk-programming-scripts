#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Generates an AHK script from a dictionary file, and language file."""

from __future__ import (absolute_import, division, print_function,
                        unicode_literals)

import datetime
import errno
from functools import singledispatch
import os
import sys
from typing import Iterable

import yaml  # pyyaml package

class KeywordError(RuntimeError):
    pass

class AbbreviationClashError(KeyError):
    """Thrown when there are multiple keywords using the same abbreviation"""
    pass


class Hotstring(object):
    FLAGS = {'no_end_char': '*', 'case_sensitive': 'c'}

    def __init__(self, word, abbrev, flags=None):
        self.word = word
        self.abbrev = abbrev
        self.flags = set()

        if flags:
            self.flags.update(flags)

    def to_ahk(self):
        hostsring_flags = ''.join((self.FLAGS[x] for x in self.flags))
        return ':{}:{}::{}\n'.format(hostsring_flags, escape_ahk(self.abbrev),
                                     escape_ahk(self.word))


@singledispatch
def make_hotstrings(item, _) -> Iterable[Hotstring]:
    raise TypeError("make_hotstring not implemented for "
                    "type {}.".format(type(item)))


@make_hotstrings.register
def _(item: str, word) -> Iterable[Hotstring]:
    """Single abbreviation"""
    return (Hotstring(word, item), )


@make_hotstrings.register
def _(item: dict, word) -> Iterable[Hotstring]:
    """Single abbreviation with flags"""
    abbrev = item['abbrev']
    flags = item['flags']
    return (Hotstring(word, abbrev, flags), )


@make_hotstrings.register
def _(item: list, word) -> Iterable[Hotstring]:
    """Single abbreviation with flags"""
    return (make_hotstrings(x, word)[0] for x in item)


def add_keyword(abbreviation, word, keywords):
    if abbreviation in keywords:
        raise AbbreviationClashError('Conflict between mappings: '
                                     '{} -> {} and {} -> {}'.format(
                                         abbreviation, keywords[abbreviation],
                                         abbreviation, word))

    keywords[abbreviation] = word


def build_dictionary(dictionary, language, hotstrings=None):
    """Adds the keywords specified in the language_file;
    Builds a dictionary to be used in the ahk script."""

    if not hotstrings:
        hotstrings = {}

    dict_keywords = dictionary['keywords']
    for word in language.keywords:
        try:
            entry = dict_keywords[word]
        except KeyError:
            raise KeywordError(f"Could not create a hotstring for '{word}', not present in the dictionary.")

        for hotstr in make_hotstrings(entry, word):
            add_keyword(hotstr.abbrev, hotstr, hotstrings)

    dict_snippets = dictionary['snippets']
    for snippet in language.snippets:
        trigger = dict_snippets[snippet] + '$'
        hotstr = Hotstring(
            language.snippet_cmd.format(snippet), trigger, ['no_end_char'])

        add_keyword(hotstr.abbrev, hotstr, hotstrings)

    # set case_sensitive flag for the hotstrings that require it.
    requires_case_sensitive = make_requires_case_sensitive(hotstrings.keys())
    for abbrev, hotstr in hotstrings.items():
        if requires_case_sensitive(hotstr.abbrev):
            hotstr.flags.add('case_sensitive')

    return hotstrings


def make_requires_case_sensitive(abbreviations):
    """Returns a funciton that returns true when the hotstring needs to be case
    sensitive

    For example, for Java, ii -> int and Ii -> Integer. The Autohotkey needs
    the case-sentitive flag to distinguish between the two hotstrings."""

    needs_case_sensitive = {}
    for abbrev in abbreviations:
        key = abbrev.lower()
        if key in needs_case_sensitive:
            needs_case_sensitive[key] = True
        else:
            needs_case_sensitive[key] = False

    def requires_case_sensitive(abbrev):
        """Returns True if the case-sensitive flag is required for this
        hotstring"""

        return needs_case_sensitive[abbrev.lower()]

    return requires_case_sensitive


def escape_ahk(to_escape):
    return to_escape.replace('#', '{#}').replace(':', '{:}')


AHK_HEADER = """; =============================================================================
; DO NOT MODIFY
; THIS IS AUTOMATICALLY GENERATED CODE
; Generated on {date}
; With '{script}'
; =============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

; ======== Add Hotstring EndChars ========
#Hotstring EndChars -()[]{{}}':;/\,.?!`n `t*<>&

; ======== Toggle Script Key ========
EnableScript := True
#c::
    Suspend, Permit
    EnableScript := not EnableScript
    if (EnableScript) {{
        Suspend, Off
        TrayMessage := "Enabled"
    }}
    else {{
        Suspend, On
        TrayMessage := "Suspended"
    }}
    TrayTip, {language} Hotstrings, %TrayMessage%, 1, 0x11
    Return

; ======== Hoststrings ========"""


def create_ahk(file_handle, keywords, language_name, script_name=__file__):
    """Generate an ahk script based on a abbreviation -> keyword dictionary."""

    file_handle.write(
        AHK_HEADER.format(
            date=datetime.datetime.now(),
            script=script_name,
            language=language_name))

    prev_letter = None
    for abbrev, abbrev_obj in sorted(
            keywords.items(), key=lambda kv: kv[1].abbrev.upper()):

        word = abbrev_obj.word

        # place empty line between words that start with a different letter
        leading_letter = word[0].lower()
        if prev_letter != leading_letter:
            file_handle.write('\n')
            prev_letter = leading_letter

        file_handle.write(abbrev_obj.to_ahk())


def find_file(filename, paths=None):
    if os.path.isfile(filename):
        return filename
    if paths:
        for path in paths:
            check_path = os.path.join(path, filename)
            if os.path.isfile(check_path):
                return check_path
    raise OSError(
        errno.ENOENT, "\"{}\" not found. Checked in '.' directory "
        "and in {}".format(filename, paths))


class Language(object):
    def __init__(self):
        self.name = None
        self.keywords = set()
        self.snippet_cmd = None
        self.snippet_trigger = '$'
        self.snippets = set()

    def _load_file(self, filename, search_paths=None, start=False):
        with open(filename, 'r') as language_file:
            language_config = yaml.load(language_file)

            if start:
                self.name = language_config['language']

            # first, load the "parent" languages.
            if 'include' in language_config:
                for lang_parent in language_config['include']:
                    self._load_file(
                        find_file(lang_parent, search_paths),
                        search_paths=search_paths)

            try:
                self.snippet_cmd = language_config['snippet_cmd']
            except KeyError:
                pass
            try:
                self.snippet_trigger = language_config['snippet_trigger']
            except KeyError:
                pass

            self.keywords.update(language_config['keywords'])

            if 'snippets' in language_config:
                self.snippets.update(language_config['snippets'])

    def load_file(self, filename, search_paths=None):
        self._load_file(filename, search_paths=search_paths, start=True)


def generate_ahk(dictionary_filename, language_filename, output_filename):
    language_dir = os.path.dirname(os.path.abspath(language_filename))

    language = Language()
    language.load_file(language_filename, search_paths=[language_dir])

    with open(dictionary_filename, 'r') as dictionary:

        keyword_map = build_dictionary(yaml.load(dictionary), language)

    with open(output_filename, 'w') as out:
        create_ahk(out, keyword_map, language.name)


def main():
    if len(sys.argv) != 4:
        print(
            "Usage: python generate_ahk.py [dictionary.yml] [language.yml] [out.ahk]"
        )
    else:
        dictionary_filename = sys.argv[1]
        language_filename = sys.argv[2]
        output_filename = sys.argv[3]
        generate_ahk(dictionary_filename, language_filename, output_filename)


if __name__ == '__main__':
    main()
