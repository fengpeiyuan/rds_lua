--  description --
-- find longest string key

-- code --
local longest
local k
local cursor = "0"
repeat
  local ret = redis.call("scan", cursor)
  cursor = ret[1]
  for _, key in ipairs(ret[2]) do
    local length = redis.pcall("strlen", key)
    if type(length) == "number" then
      if longest == nil or length > longest then
        longest = length
        k = key
      end
    end
  end
until cursor == "0"
return k

-- command --
eval 'local longest local k local cursor = "0" repeat local ret = redis.call("scan", cursor) cursor = ret[1] for _, key in ipairs(ret[2]) do local length = redis.pcall("strlen", key)  if type(length) == "number" then if longest == nil or length > longest then longest = length k = key end  end end until cursor == "0" return k' 0