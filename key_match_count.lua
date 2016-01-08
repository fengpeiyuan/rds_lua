--  description --
-- count match keys` number

-- code --
local cursor = "0"
local sum = 0
repeat
  local ret = redis.call("scan", cursor,"MATCH",KEYS[1])
  cursor = ret[1]
  sum = sum + #ret[2]
until cursor == "0"
return sum


-- command --
eval 'local cursor = "0" local sum = 0 repeat local ret = redis.call("scan", cursor,"MATCH",KEYS[1]) cursor = ret[1] sum = sum + #ret[2] until cursor == "0" return sum' 1 {matchstring}