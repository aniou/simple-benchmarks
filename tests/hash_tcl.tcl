
while {[gets stdin line] > -1} {
	if {[lindex $line 0] != "valid-data:"} continue
	set key [string trim [lindex $line 1] "\""] 
    set number [lindex $line 3]
    lappend data($key) $number
}

#parray data
puts -nonewline [array size data]
puts -nonewline ","

