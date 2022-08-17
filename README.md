# multi_server_stats
Bash script that gathers hourly average traffic statistics (outgoing) from multiple servers and sends it to Telegram using bot.

## Install & Configure

### Telegram channel and bot

Create bot and **copy token** (xxxxxxxxx:xxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxx). Add bot as admin to some designated channel where you participate and where you want to send statistics (or create one). Send `test` message from your telegram account in that channel. Go to `https://api.telegram.org/botxxxxxxxxx:xxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxx/getUpdates` and **copy chat id** from JSON entry for `test` message (look into the end of that JSON).

### Servers for monitoring:

```
sudo apt update
sudo apt install vnstat openssh-server
```

### Server to run script as a cron job:

```
sudo apt update
sudo apt install sshpass jq
```

`curl -Lo multi_server_stats.sh https://raw.githubusercontent.com/jgoodies/multi_server_stats/main/multi_server_stats.sh`

`nano multi_server_stats.sh` -- enter telegram bot **token** and **chat id** there

`chmod +x multi_server_stats.sh`

`curl -Lo multi_server_stats.ini https://raw.githubusercontent.com/jgoodies/multi_server_stats/main/multi_server_stats.ini`

`nano multi_server_stats.ini` -- add servers; ip and password first; then enter username (if not root); and then ssh port (if not 22); separate logically using empty line; use 127.0.0.1 for current server to be monitored if needed (and don't forget to install `vnstat openssh-server` there)

`sudo nano /etc/crontab` -- add line `10 *    * * *   foouser    test -x /home/foouser/multi_server_stats.sh && /home/foouser/multi_server_stats.sh > /dev/null 2>&1` to the end.
