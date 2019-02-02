#!/bin/sh

run() {
    (for a in $(seq 1 3); do
        cat test-data.txt | /usr/bin/time -f '%C,%E,%e,%P,%M' "$@" 2>&1
    done) | awk -F , '{t+=$4; cpu+=$5; mem+=$6}
                      END {
                        printf("%s,%s,%s%%,%s\n", $2, t/NR, cpu/NR, mem/NR)
                      }'
}

run                 tests/hash_nim
run python3.6       tests/hash_py.py
run python2.7       tests/hash_py.py
run                 tests/hash_pike.pike
run ~/src/lily/lily tests/hash_lily.lily
run                 tests/hash_crystal
run                 tests/hash_go
run tclsh8.6        tests/hash_tcl.tcl
run jimsh           tests/hash_tcl.tcl
run  lua5.3         tests/hash_lua.lua
run  luajit         tests/hash_lua.lua
run ruby2.5         tests/hash_ruby.rb
run ruby2.6         tests/hash_ruby.rb
run ruby2.6 --jit   tests/hash_ruby.rb
run ruby2.5         tests/hash_ruby-smaller.rb
run ruby2.6         tests/hash_ruby-smaller.rb
run ruby2.6 --jit   tests/hash_ruby-smaller.rb
# about 10 minutes for single pass...
#run ~/src/wren/wren tests/hash_wren.wren

# TODO?
# never
# dao
# sparkling
# forth ;)

