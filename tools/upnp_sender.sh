#!/bin/bash

URL=http://192.168.0.1:1900
CONTROL_PATH=/control?WFAWLANConfig
SERVICE_TYPE=urn:schemas-wifialliance-org:service:WFAWLANConfig:1
ACTION=GetDeviceInfo
BODY=''

curl "${URL}${CONTROL_PATH}" -X 'POST' -H 'Content-Type: text/xml; charset="utf-8"' -H 'Connection: close' \
    -H "SOAPAction: \"${SERVICE_TYPE}#${ACTION}\"" \
    -d \
"<?xml version=\"1.0\"?>
<s:Envelope xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\" s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">
    <s:Body>
        <u:${ACTION} xmlns:u=\"${SERVICE_TYPE}\">
            ${BODY}
        </u:${ACTION}>
    </s:Body>
</s:Envelope>"
