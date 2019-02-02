# simple-benchmarks
Set of simple benchmarks for my personal projects

# hash benchmark

## preparing random data

total length
```
$ ./create-test-data.py > test-data.txt
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

## sample program

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
#print data.size
#print ","
```

result 
```
$ grep -E '(4Fw82H59LwwC76athMn|oZqXkMuAIgNi6g9q)' ../test-data.txt | ruby2.6 hash_ruby-sample.rb
{"4Fw82H59LwwC76athMn"=>[65036, 22134, 51213, 34724, 6232, 21687, 43780],
 "oZqXkMuAIgNi6g9q"=>[18592, 20870, 59030, 13547]}
```


