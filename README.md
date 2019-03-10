# watcha

## Usage

```bash
./watcha.sh [-h,--help] [-v,--verbose] -i interface
```

## Installation

```
# Linux Debian/Ubuntu
apt-get install bc sudo ipcalc nmap dig

# MacOS
brew install bc sudo ipcalc nmap iproute2mac dig
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

### WATCHA

```
$ ./watcha.sh -i wlp4s0

Device:     wlp4s0
IP:         192.168.0.11/24
Network:    192.168.0.0/24
Gateway:    192.168.0.1
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

### .local resolver

```
$ ./tools/resolver.sh
192.168.0.2 <=> something.local.
192.168.0.29 <=> iphone-someone.local.
```

### UPNP

```
$ ./tools/upnp.sh wlp4s0
found 0 associations
found 1 connections:
     1: flags=92<CONNECTED,BOUND_IF,PREFERRED>
  outif (null)
  src 192.168.0.99 port 54830
  dst 239.255.255.250 port 1900
  rank info not available

Connection to 239.255.255.250 port 1900 [udp/ssdp] succeeded!

Be patient, wait a minute... (Ctrl+C to stop)
After the run, you could try a 'tools/upnp_help.sh'

Location: http://192.168.0.10:6060
Name: LABOXDXXX
Server: Sagemcom STB WebService Controler
Location: http://192.168.0.1:80/RootDevice.xml
Server: UPnP/1.0 UPnP/1.0 UPnP-Device-Host/1.0
```

```
$ ./tools/upnp_help.sh
Sort Location:
--------------
Location: http://192.168.0.10:6060
Location: http://192.168.0.1:80/RootDevice.xml
Help: curl -svLk  --connect-timeout 2 --max-time 2 -A "" LOCATION

Sort Name:
----------
Name: LABOXDXXX

Sort Server:
----------
Server: Sagemcom STB WebService Controler
Server: UPnP/1.0 UPnP/1.0 UPnP-Device-Host/1.0

Sort source IP:
---------------
192.168.0.1.1900
192.168.0.1.1901
192.168.0.10.53700
192.168.0.2.1900
192.168.0.99.63179
```
