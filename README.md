# watcha

## Usage

```bash
./watcha.sh <interface name>
```

## Installation

```
apt-get install bc sudo ipcalc nmap
```

## Introduction

This tool permits to scan the network (which it subdivides into some /24) and help the exploit by giving some commands.
The nmap should be a little bit discret (usage of Spoofing IP not really simple).


**Supported :**

  - **FTP** (scanned, helpful script)
  - **SSH** (display banner)
  - SMTP (scanned, not helped)
  - **HTTP / HTTPS / HTTP-PROXY** (discret curl, display server name)
  - **SAMBA** (display guest command, helpful script, auto-test guest no-password credentials)


## Example

```
$ ./watcha.sh wlp4s0

Device:     wlp4s0
IP:         192.168.0.11/24
Network:    192.168.0.0/24
Spoofed IP: 192.168.0.4

====SCAN====
... tail -f /tmp/.watcha.output

 192.168.0.1   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/OPEN/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.0.2   21/OPEN/ftp, 22/closed/ssh, 25/closed/smtp, 80/OPEN/http, 443/closed/https, 445/OPEN/microsoft-ds, 8080/closed/http-proxy
 192.168.0.3   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/closed/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.0.10   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/closed/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.0.12   21/filtered/ftp, 22/filtered/ssh, 25/filtered/smtp, 80/filtered/http, 443/filtered/https, 445/filtered/microsoft-ds, 8080/filtered/http-proxy
 192.168.0.13   21/filtered/ftp, 22/filtered/ssh, 25/filtered/smtp, 80/filtered/http, 443/filtered/https, 445/filtered/microsoft-ds, 8080/filtered/http-proxy

====LINK====
FTP link:
    tools/ftp.sh 192.168.0.2 admin password
HTTP link:
    curl -A "" http://192.168.0.1:80/ >/dev/null -vs
    curl -A "" http://192.168.0.2:80/ >/dev/null -vs
SAMBA link:
    tools/ftp.sh 192.168.0.2

====HELP====
HTTP help:
    http://192.168.0.1:80/  ==> 
    http://192.168.0.2:80/  ==> Server: lighttpd/1.4.31
SAMBA help:
    smbclient -L //192.168.0.2 -U guest --no-pass  ==>  smbclient //192.168.0.2/<Sharename> -U guest --no-pass
MAC help:
192.168.0.1
MAC Address: 18:1E:78:CE:B5:3C (Sagemcom Broadband SAS)
192.168.0.2
MAC Address: 8C:10:D4:D2:D7:36 (Sagemcom Broadband SAS)
```
