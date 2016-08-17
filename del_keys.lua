--  description --
-- like flushdb 

-- 1. lua+shell --
local cursor = "0"
repeat
  local ret = redis.call("scan", cursor)
  cursor = ret[1]
  for _, key in ipairs(ret[2]) do
	redis.log(redis.LOG_NOTICE,key)	
  end
until cursor == "0"
return 

-- command --
eval 'local cursor = "0" repeat local ret = redis.call("scan", cursor) cursor = ret[1] for _, key in ipairs(ret[2]) do redis.log(redis.LOG_NOTICE,key) end until cursor == "0" return' 0 

awk 'BEGIN{FS=" "} {print $6}' /var/log/redis_10567.log |xargs /opt/redis/bin/redis-cli -p 10567 del


eval 'local cursor = "0" repeat local ret = redis.call("scan", cursor,"MATCH","ocard-*") cursor = ret[1] for _, key in ipairs(ret[2]) do redis.log(redis.LOG_NOTICE,key) end until cursor == "0" return' 0 

awk 'BEGIN{FS=" "} {print $6}' /var/log/redis_10640.log |xargs /opt/redis/bin/redis-cli -p 10640 del

-- 2.shell --

#!/bin/sh

cur=0
r=''
key=''

r=`/opt/redis/bin/redis-cli -p 10568 scan $cur COUNT 1`
#echo $r
cur=`echo $r|awk 'BEGIN{FS=" "} {print $1}'`
key=`echo $r|awk 'BEGIN{FS=" "} {print $2}'`
echo $cur-$key

while [ $cur != '0' ]
do
        r=`/opt/redis/bin/redis-cli -p 10568 scan $cur COUNT 1`
        #echo $r
        cur=`echo $r|awk 'BEGIN{FS=" "} {print $1}'`
        key=`echo $r|awk 'BEGIN{FS=" "} {print $2}'`
        #echo $cur-$key
        /opt/redis/bin/redis-cli -p 10568 del $key
done





