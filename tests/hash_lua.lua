
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


data = {}
str = io.read()
while str do
    if string.sub(str, 1,11) == "valid-data:" then
        tokens=split(str, " ")
        key = tokens[2]:gsub("^\"(.+)\"$", "%1")
        number = tonumber(tokens[4])
        if (data[key] == nil) then
            data[key] = {}
        end
        table.insert(data[key], number)
    end
    str = io.read()
end

--print(dump(data))
io.write(tablelength(data))
io.write(",")

-- eof
