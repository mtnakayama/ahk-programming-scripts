
from __future__ import absolute_import, division, print_function
import string

macroString = """~[KEY]::
    SendInput ^{Space}
    Return"""
    
def main():
    additionalTrigers = ['TAB', '^ENTER', 'SPACE']
    lowercaseLetters = [x for x in string.ascii_lowercase]
    uppercaseLetters = ['+' + x for x in string.ascii_lowercase]
    triggers = additionalTrigers + lowercaseLetters + uppercaseLetters
    for letter in triggers:
        print(macroString.replace('[KEY]', letter))
    
if __name__ == '__main__':
    main()
        
