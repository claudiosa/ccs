#!/bin/bash
openvpn --config  us-phx.prod.surfshark.com_udp.ovpn  --auth-user-pass key_vpn.pass

echo 'Connected!'
export DISPLAY=:0.0
ps -a | grep openvpn
echo 'VPN running in this process.'
