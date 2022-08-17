# multi_server_stats
bash script that gathers hourly average traffic statistics from multiple servers and sends it to telegram

on all servers:

```
sudo apt update
sudo apt install vnstat
```

on main server:

`curl -Lo https://raw.githubusercontent.com/jgoodies/multi_server_stats/main/multi_server_stats.sh`

`nano multi_server_stats.sh` -- enter telegram bot token and chat id there

`chmod +x multi_server_stats.sh`

`curl -Lo https://raw.githubusercontent.com/jgoodies/multi_server_stats/main/multi_server_stats.ini`

`nano multi_server_stats.ini` -- add servers; ip and password first; then enter username (if not root); and then ssh port (if not 22); separate logically using empty line

`sudo nano /etc/crontab` -- add line `10 *    * * *   foouser    test -x /home/foouser/multi_server_stats.sh && /home/jhou/multi_server_stats.sh > /dev/null 2>&1` to the end.
