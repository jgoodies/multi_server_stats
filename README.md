# multi_server_stats
bash script that gathers hourly average traffic statistics from multiple servers and sends it to telegram

on servers for monitoring:

```
sudo apt update
sudo apt install vnstat openssh-server
```

on server to run script as a cron job:

```
sudo apt update
sudo apt install sshpass jq
```

`curl -Lo multi_server_stats.sh https://raw.githubusercontent.com/jgoodies/multi_server_stats/main/multi_server_stats.sh`

`nano multi_server_stats.sh` -- enter telegram bot token and chat id there

`chmod +x multi_server_stats.sh`

`curl -Lo multi_server_stats.ini https://raw.githubusercontent.com/jgoodies/multi_server_stats/main/multi_server_stats.ini`

`nano multi_server_stats.ini` -- add servers; ip and password first; then enter username (if not root); and then ssh port (if not 22); separate logically using empty line; use 127.0.0.1 for current server to be monitored too (and don't forget to install `vnstat openssh-server` there)

`sudo nano /etc/crontab` -- add line `10 *    * * *   foouser    test -x /home/foouser/multi_server_stats.sh && /home/foouser/multi_server_stats.sh > /dev/null 2>&1` to the end.
