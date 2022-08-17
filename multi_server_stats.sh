#!/bin/bash
#while true; do
  printf "\n--------------------------\n"
  KOUNT=0
  SUM=0.0
  SERVERS=""
  CURR=""
  UNREACHABLE=""
  UNREACHABLE_STR=""
  
  while read -r IP PASS USER PORT; do
    #echo "IP = |$IP| PASS = |$PASS| USER = |$USER| PORT = |$PORT|"
    if [[ -z "$PORT" ]];
    then
      PORT="22"
    fi
    if [[ -z "$USER" ]];
    then
      USER="root"
    fi
    if ! [[ -z "$PASS" ]];
    then
      CURR="$(sshpass -p $PASS ssh -p $PORT -tt -no StrictHostKeyChecking=accept-new $USER@$IP 'vnstat --json h 2' | jq '.interfaces[0].traffic.hour[0].tx')" # first try ...
      if [[ -z "$CURR" ]]; # ... if not successful ...
      then
        CURR="$(sshpass -p $PASS ssh -p $PORT -tt -no StrictHostKeyChecking=accept-new $USER@$IP 'vnstat --json h 2' | jq '.interfaces[0].traffic.hour[0].tx')" # ... do the second try to eliminate possible intermittent connection problem
      fi
      if ! [[ -z "$CURR" ]];
      then
        CURR=$(bc <<< "scale=2;$CURR * 2 / 900000000")
        KOUNT=$(( $KOUNT + 1 ))
        SUM=$(bc <<< "$SUM + $CURR")
        printf -v CURR "%+7s" ${CURR}
      else
        printf -v CURR "%+7s" "x"
        printf -v IP "%+17s" ${IP}
        UNREACHABLE+="%0A$IP"
      fi
      SERVERS+="+$CURR"
    else
      SERVERS+="%0A"
    fi
  done <multi_server_stats.ini
  
  SERVERS=${SERVERS// /$'+'}
  UNREACHABLE=${UNREACHABLE// /$'+'}
  
  #echo "UNREACHABLE = |$UNREACHABLE|"
  if ! [[ -z "$UNREACHABLE" ]];
  then
    UNREACHABLE_STR="%0Aunreachable+servers%3A$UNREACHABLE"
  fi
    
  if [ "$KOUNT" -gt 0 ];
  then
    curl "https://api.telegram.org/botxxxxxxxxxx:xxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxx/sendMessage?chat_id=-xxxxxxxxxxxxx&text=Last+hour+avg+traffic+%3D+$SUM+Mbit%2Fs%3B%0Aservers+($KOUNT,+in+Mbit%2Fs)%3A%0A$SERVERS$UNREACHABLE_STR"
  fi
#  sleep 60
#done
