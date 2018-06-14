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

  - FTP (scanned, not helped)
  - **SSH** (display banner)
  - SMTP (scanned, not helped)
  - **HTTP / HTTPS / HTTP-PROXY** (discret curl, display server name)
  - **SAMBA** (display guest command, auto-test guest no-password credentials)


## Example

```
$ ./watcha.sh wlp4s0
Device:     wlp4s0
IP:         192.168.182.56/24
Network:    192.168.182.0/24
Spoofed IP: 

====SCAN====
... tail -f /tmp/.watcha.output

 192.168.182.1   21/filtered/ftp, 22/filtered/ssh, 25/filtered/smtp, 80/OPEN/http, 443/filtered/https, 445/filtered/microsoft-ds, 8080/filtered/http-proxy
 192.168.182.4   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/OPEN/http, 443/OPEN/https, 445/closed/microsoft-ds, 8080/OPEN/http-proxy
 192.168.182.6   21/filtered/ftp, 22/filtered/ssh, 25/filtered/smtp, 80/filtered/http, 443/filtered/https, 445/filtered/microsoft-ds, 8080/filtered/http-proxy
 192.168.182.49   21/filtered/ftp, 22/closed/ssh, 25/filtered/smtp, 80/filtered/http, 443/filtered/https, 445/filtered/microsoft-ds, 8080/filtered/http-proxy
 192.168.182.51   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/closed/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.182.60   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/closed/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.182.61   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/closed/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.182.63   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/OPEN/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy
 192.168.182.56   21/closed/ftp, 22/closed/ssh, 25/closed/smtp, 80/closed/http, 443/closed/https, 445/closed/microsoft-ds, 8080/closed/http-proxy

====LINK====
HTTP link:
    curl -A "" http://192.168.182.1:80/ >/dev/null -vs
    curl -A "" http://192.168.182.4:80/ >/dev/null -vs
    curl -A "" http://192.168.182.63:80/ >/dev/null -vs
HTTPS link:
    curl -Ak "" https://192.168.182.4:443/ >/dev/null -vs
SAMBA link:
    smbclient -L //192.168.182.49 -U guest --no-pass
HTTP-PROXY link:
    curl -A "" http://192.168.182.4:8080/ >/dev/null -vs

====HELP====
HTTP help:
    http://192.168.182.1:80/  ==> Server: nginx/1.2.1
    http://192.168.182.4:80/  ==> Server: HP HTTP Server; HP HP OfficeJet Pro 8710 - D9L18A; Serial Number: XXXXXXXXXX; Built:Wed Apr 19, 2017 09:40:48AM {WBP2CN1716AR}
    http://192.168.182.63:80/  ==> Server: Web Server
HTTPS help:
    https://192.168.182.4:443/  ==> Server: HP HTTP Server; HP HP OfficeJet Pro 8710 - D9L18A; Serial Number: XXXXXXXXXX; Built:Wed Apr 19, 2017 09:40:48AM {WBP2CN1716AR}
SAMBA help:
    smbclient -L //192.168.182.49 -U guest --no-pass  ==> 
HTTP-PROXY help:
    http://192.168.182.4:8080/  ==> Server: HP HTTP Server; HP HP OfficeJet Pro 8710 - D9L18A; Serial Number: XXXXXXXXXX; Built:Wed Apr 19, 2017 09:40:48AM {WBP2CN1716AR}
MAC help:
192.168.182.1
MAC Address: 20:4E:7F:06:B3:1E (Netgear)
192.168.182.4
MAC Address: 18:60:24:06:87:BB (Hewlett Packard)
192.168.182.49
MAC Address: 9C:B6:D0:F3:CF:93 (Rivet Networks)
192.168.182.63
MAC Address: 08:BD:43:C7:5F:00 (Netgear)
```
