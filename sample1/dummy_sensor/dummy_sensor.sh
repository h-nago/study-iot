#/bin/bash
temp=20
echo "start with $temp"
while true
do
  temp=$((temp+$(($RANDOM % 3))-1))
  echo $temp
  curl http://fluentd-frontend:9880 -XPOST -H "Content-Type: application/json" -d'{"temp":'"$temp"',"timestamp":'"$(date +%s)"'}'
  sleep 1
done