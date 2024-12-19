#!/bin/bash

echo "请输入文件路径："
read folder_path

if [ ! -d "$folder_path" ]; then
  echo "输入的路径无效，请重新运行脚本并提供正确的路径。"
  exit 1
fi

vps_ip=$(curl -s ifconfig.me)

if [ -z "$vps_ip" ]; then
  echo "无法获取VPS的公网IP。"
  exit 1
fi

output_file="${vps_ip}.txt"

> "$output_file"

find "$folder_path" -type f -name "private_key" | while read private_key_file; do
  if [ -f "$private_key_file" ]; then
    echo "正在处理: $private_key_file"
    cat "$private_key_file" >> "$output_file"
    echo -e "\n\n" >> "$output_file" 
  fi
done

echo "所有 private_key 已归集到文件: $output_file"