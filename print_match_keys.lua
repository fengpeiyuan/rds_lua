--  description --
-- print match keys in redis log

-- code --
local cursor = "0"
local limit = KEYS[2]
local sum = 0
repeat
  local ret = redis.call("scan", cursor,"MATCH",KEYS[1])
  cursor = ret[1]
  sum = sum + #ret[2]
  for _, key in ipairs(ret[2]) do
    redis.log(redis.LOG_NOTICE,key)
  end
  if limit > 0 then
	  if sum >= limit then
	    return sum
	  end
  end
until cursor == "0"
return sum



-- command --
eval 'local cursor = "0" local sum = 0 repeat local ret = redis.call("scan", cursor,"MATCH",KEYS[1]) cursor = ret[1] sum = sum + #ret[2] for _, key in ipairs(ret[2]) do redis.log(redis.LOG_NOTICE,key) end if sum > 300 then return sum end until cursor == "0" return sum' 2 {*str*} 0 


