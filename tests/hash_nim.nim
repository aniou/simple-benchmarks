
# ~/src/nim-0.19.2/bin/nim c --d:release  hash_nim.nim 


import strutils
import tables

var
 data = initTable[string, seq[uint16]]()

for line in stdin.lines:
  if not line.startsWith("valid-data:"): continue
  let tokens = line.splitWhitespace()
  let key    = tokens[1].strip(chars = {'"'})
  let number = uint16(tokens[3].parseUint())
  if data.has_key(key): 
    data[key].add(number)
  else:
    data[key] = @[number]

#stdout.write data
stdout.write data.len()
stdout.write ","

