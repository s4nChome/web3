#!/bin/bash

echo "请输入文件路径："
read folder_path

if [ ! -d "$folder_path" ]; then
  echo "输入的路径无效，请重新运行脚本并提供正确的路径。"
  exit 1
fi

# 获取VPS的公网IP
vps_ip=$(curl -s ifconfig.me)

# 检查是否获取到公网IP
if [ -z "$vps_ip" ]; then
  echo "无法获取VPS的公网IP。"
  exit 1
fi

output_file="${vps_ip}.txt"

> "$output_file"

find "$folder_path" -type f -name "private_key" | while read private_key_file; do
  # 如果文件存在，读取并将内容追加到输出文件
  if [ -f "$private_key_file" ]; then
    echo "正在处理: $private_key_file"
    cat "$private_key_file" >> "$output_file"
  fi
done

echo "所有 private_key 已归集到文件: $output_file"