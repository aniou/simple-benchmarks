
from __future__ import print_function
import fileinput
import collections

data = collections.defaultdict(list)
for line in fileinput.input():
    if not line.startswith('valid-data:'): continue
    tokens = line.split()
    key = tokens[1].strip('"')
    number = int(tokens[3])
    data[key].append(number)

#print('ok')
print(len(data), end=",")
