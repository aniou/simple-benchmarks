#!/usr/bin/python3.6

import fileinput
import random
import sys
import string

# prefixes
prefixes   = ['valid-data:', 'commented::', 'random-foo:']

# words
min_char = 4
max_char = 55
allchar  = string.ascii_letters + string.digits
words      = ["".join(random.choice(allchar) for x in range(random.randint(min_char, max_char))) 
              for _ in range(400000)
             ]

# test lines
count=0
while count < 2_000_000:
    prefix  = random.choices(prefixes,[5,1,1])[0]
    name    = random.choice(words)
    number  = random.randint(0,65535)
    if prefix == 'valid-data:':
        count=count+1

    print('{} "{}" foo {}'.format(prefix, name, number))

