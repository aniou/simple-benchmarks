# simple-benchmarks

## hash benchmark

### result
```
test                                     time   cpu      mem/KiB of fastest of smallest
tests/hash_go                             2,12  108.00%  127684  100,00%    108,95%
tests/hash_nim                            3,55   98.33%  133783  167,61%    114,15%
tests/hash_crystal                        3,83  123.33%  121595  180,66%    103,75%
python2.7 tests/hash_py.py                6,95   97.33%  166629  327,67%    142,18%
tests/hash_pike.pike                      7,15   98.33%  155217  337,11%    132,44%
python3.6 tests/hash_py.py                7,21   98.67%  172015  339,94%    146,77%
src/lily/lily tests/hash_lily.lily        8,22   98.67%  180632  387,58%    154,13%
ruby2.5 tests/hash_ruby.rb                8,85   98.33%  157831  417,45%    134,67%
ruby2.6 tests/hash_ruby.rb                9,48   98.00%  157673  447,17%    134,54%
ruby2.6 --jit tests/hash_ruby.rb         10,30  191.67%  159009  485,69%    135,68%
luajit tests/hash_lua.lua                10,64   99.00%  188473  501,73%    160,82%
tclsh8.6 tests/hash_tcl.tcl              11,05   98.67%  323831  521,38%    276,31%
ruby2.5 tests/hash_ruby-smaller.rb       12,89   99.00%  117308  607,86%    100,09%
ruby2.6 tests/hash_ruby-smaller.rb       14,42   99.00%  143492  680,34%    122,44%
jimsh tests/hash_tcl.tcl                 16,66   99.00%  349313  786,00%    298,06%
lua5.3 tests/hash_lua.lua                16,81   99.00%  338732  792,77%    289,03%
ruby2.6 --jit tests/hash_ruby-smaller.rb 17,80  191.33%  117197  839,78%    100,00%

test                                     time   cpu      mem/KiB of fastest of smallest
ruby2.6 --jit tests/hash_ruby-smaller.rb 17,80  191.33%  117197  839,78%    100,00%
ruby2.5 tests/hash_ruby-smaller.rb       12,89   99.00%  117308  607,86%    100,09%
tests/hash_crystal                        3,83  123.33%  121595  180,66%    103,75%
tests/hash_go                             2,12  108.00%  127684  100,00%    108,95%
tests/hash_nim                            3,55   98.33%  133783  167,61%    114,15%
ruby2.6 tests/hash_ruby-smaller.rb       14,42   99.00%  143492  680,34%    122,44%
tests/hash_pike.pike                      7,15   98.33%  155217  337,11%    132,44%
ruby2.6 tests/hash_ruby.rb                9,48   98.00%  157673  447,17%    134,54%
ruby2.5 tests/hash_ruby.rb                8,85   98.33%  157831  417,45%    134,67%
ruby2.6 --jit tests/hash_ruby.rb         10,30  191.67%  159009  485,69%    135,68%
python2.7 tests/hash_py.py                6,95   97.33%  166629  327,67%    142,18%
python3.6 tests/hash_py.py                7,21   98.67%  172015  339,94%    146,77%
src/lily/lily tests/hash_lily.lily        8,22   98.67%  180632  387,58%    154,13%
luajit tests/hash_lua.lua                10,64   99.00%  188473  501,73%    160,82%
tclsh8.6 tests/hash_tcl.tcl              11,05   98.67%  323831  521,38%    276,31%
lua5.3 tests/hash_lua.lua                16,81   99.00%  338732  792,77%    289,03%
jimsh tests/hash_tcl.tcl                 16,66   99.00%  349313  786,00%    298,06%                           
```

### preparing data
```
$ ./create-test-data.py > test-data.txt
```
total length
```
$ wc -l test-data.txt 
2801337 test-data.txt
```
"valid" lines
```
$ grep valid-data: test-data.txt | wc -l
2000000
```
unique keys
```
$ grep valid-data: test-data.txt | cut -f 2 -d ' ' | sort | uniq | wc -l
397350

```

### testing
```
$ grep -E '(4Fw82H59LwwC76athMn|oZqXkMuAIgNi6g9q)' ../test-data.txt
valid-data: "4Fw82H59LwwC76athMn" foo 65036
valid-data: "oZqXkMuAIgNi6g9q" foo 18592
random-foo: "oZqXkMuAIgNi6g9q" foo 32272
valid-data: "4Fw82H59LwwC76athMn" foo 22134
random-foo: "4Fw82H59LwwC76athMn" foo 39358
valid-data: "oZqXkMuAIgNi6g9q" foo 20870
valid-data: "4Fw82H59LwwC76athMn" foo 51213
valid-data: "oZqXkMuAIgNi6g9q" foo 59030
valid-data: "oZqXkMuAIgNi6g9q" foo 13547
commented:: "4Fw82H59LwwC76athMn" foo 20785
random-foo: "4Fw82H59LwwC76athMn" foo 25953
random-foo: "oZqXkMuAIgNi6g9q" foo 25155
valid-data: "4Fw82H59LwwC76athMn" foo 34724
valid-data: "4Fw82H59LwwC76athMn" foo 6232
valid-data: "4Fw82H59LwwC76athMn" foo 21687
valid-data: "4Fw82H59LwwC76athMn" foo 43780
```
sample program
```ruby
data = Hash.new {|hsh, key| hsh[key] = [] }
ARGF.each_line do |line|
    next if not line.start_with?('valid-data:')
    tokens = line.split()
    key = tokens[1].delete_prefix('"').delete_suffix('"')
    number = tokens[3].to_i
    data[key].push(number)
end

# only for debug
pp data

# for benchmark
print data.size
print ","
```
result 
```
$ grep -E '(4Fw82H59LwwC76athMn|oZqXkMuAIgNi6g9q)' ../test-data.txt | ruby2.6 hash_ruby-sample.rb
{"4Fw82H59LwwC76athMn"=>[65036, 22134, 51213, 34724, 6232, 21687, 43780],
 "oZqXkMuAIgNi6g9q"=>[18592, 20870, 59030, 13547]}
 2,
```
