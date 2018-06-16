FROM debian:latest

RUN echo "deb http://deb.debian.org/debian stretch non-free" >> /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y git ipcalc nmap bc sudo; \
    apt-get install -y curl smbclient ssh nikto tcpdump telnet vim net-tools ftp; \
    git clone https://github.com/nbeguier/watcha.git
