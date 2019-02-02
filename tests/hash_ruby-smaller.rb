
data = Hash.new {|hsh, key| hsh[key] = [] }
ARGF.each_line do |line|
    next if not line.start_with?('valid-data:')
    tokens = line.split()
    key = tokens[1].delete_prefix('"').delete_suffix('"')
    number = tokens[3].to_i
    data[key] += [number]
end

#pp data
print data.size
print ","
$stdout.flush

