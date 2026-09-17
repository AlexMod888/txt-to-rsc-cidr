#!/bin/bash
SRC_URL="https://raw.githubusercontent.com/lord-alfred/ipranges/main/openai/ipv4_merged.txt"
OUT_FILE="gpt-list.rsc"
LIST_NAME="gpt-list"

curl -s "$SRC_URL" -o ipv4_merged.txt

{
  echo "/ip firewall address-list remove [find list=$LIST_NAME];"
  while read -r ip; do
    [ -z "$ip" ] && continue
    echo "/ip firewall address-list add list=$LIST_NAME address=$ip comment=openai-auto;"
  done < ipv4_merged.txt
} > "$OUT_FILE"
