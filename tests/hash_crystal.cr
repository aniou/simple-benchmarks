
# crystal build --release hash_crystal.cr 
#
data = Hash(String, Array(UInt16)).new

STDIN.each_line do |line|
  next if !line.starts_with?("valid-data:")
  tokens = line.split()
  key = tokens[1].strip("\"")
  number = tokens[3].to_u16
  if data.has_key?(key) 
    data[key].push(number)
  else 
    data[key] = [number]
  end

end

#pp data
print data.size
print ","
