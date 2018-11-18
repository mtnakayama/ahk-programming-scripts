#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Generates an AHK script from a dictionary file, and language file."""

from __future__ import (absolute_import, division, print_function,
                        unicode_literals)

import datetime
import errno
import os
import sys

import six
import yaml  # pyyaml package


class AbbreviationClashError(KeyError):
    """Thrown when there are multiple keywords using the same abbreviation"""
    pass


class Abbreviation(object):
    FLAGS = {'no_end_char': '*', 'case_sensitive': 'c'}

    def __init__(self, word, abbrev, flags=None):
        self.word = word
        self.abbrev = abbrev

        if not flags:
            self.flags = ''
        else:
            self.flags = ''.join((self.FLAGS[x] for x in flags))


def add_keyword(abbreviation, word, keywords):
    if abbreviation in keywords:
        raise AbbreviationClashError('Conflict between mappings: '
                                     '{} -> {} and {} -> {}'.format(
                                         abbreviation, keywords[abbreviation],
                                         abbreviation, word))

    keywords[abbreviation] = word


def build_dictionary(dictionary, language, keywords=None):
    """Adds the keywords specified in the language_file;
    Builds a dictionary to be used in the ahk script."""

    if not keywords:
        keywords = {}

    for word in language:
        abbreviation = dictionary[word]
        if isinstance(abbreviation, six.string_types):  # single abbrevation
            add_keyword(abbreviation, Abbreviation(word, abbreviation),
                        keywords)

        elif isinstance(abbreviation, dict):
            abbrev = abbreviation['abbrev']
            flags = abbreviation['flags']
            add_keyword(abbrev, Abbreviation(word, abbrev, flags), keywords)

        else:  # abbreviation holds multiple
            for abbr in abbreviation:
                add_keyword(abbr, Abbreviation(word, abbr), keywords)

    return keywords


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

    requires_case_sensitive = make_requires_case_sensitive(keywords.keys())

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

        flags = abbrev_obj.flags
        if requires_case_sensitive(abbrev) and 'c' not in flags:
            flags += 'c'
        file_handle.write(':{}:{}::{}\n'.format(flags, escape_ahk(abbrev),
                                                escape_ahk(word)))


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
        self.snippets = set()

    def _load_file(self, filename, search_paths=None, start=False):
        with open(filename, 'r') as language_file:
            language_config = yaml.load(language_file)

            if start:
                self.name = language_config

            # first, load the "parent" languages.
            if 'include' in language_config:
                for lang_parent in language_config['include']:
                    self._load_file(
                        find_file(lang_parent, search_paths),
                        search_paths=search_paths)

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

        keyword_map = build_dictionary(
            yaml.load(dictionary)['dictionary'], language.keywords)

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
