#!/bin/bash
wifiToggle=$(nmcli -fields WIFI g | \
  awk '/enabled|disabled/ {if($1 == "enabled") {print "off"} else {print "on"}}')

option=$(echo -e "1. toggle wifi $wifiToggle\n2. select known wifi\n3. scan for networks" | \
  wofi --show=dmenu -p "Wifi menu: " --cache-file=/dev/null | \
  awk -F "" '{print $1}')

if [[ $option == "1" ]]; then
  # toggle wifi on/off
  nmcli radio wifi $wifiToggle
elif [[ $option == "2" ]]; then  
  # select known network and connect
  known=$(nmcli --fields=type,name connection show | awk '$1 == "wifi" {print $2}')
  ssid=$(echo "$known" | wofi --show=dmenu -p "select known wifi:" --cache-file=/dev/null)
  if [[ -n "$ssid" ]]; then
    nmcli connection up $ssid
  fi
elif [[ $option == "3" ]]; then
  # scan for networks and connect
  fields="bssid,ssid,signal,bars,rate,security,in-use"
  list=$(nmcli -f $fields device wifi | sed -n '1!p')
  if [[ -n "$list" ]]; then
    bssid=$(echo "$list" | wofi --show=dmenu -p "Select wifi:" --cache-file=/dev/null | \
      awk '{print $1}')
  fi
  if [[ -n "$bssid" ]]; then
    pass=$(echo "" | \
      wofi --show=dmenu -p "Enter password:" --cache-file=/dev/null --password --lines=1)
    nmcli device wifi connect $bssid password $pass
  fi
else
  echo "invalid menu option"
fi

