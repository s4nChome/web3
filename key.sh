#!/bin/bash

folder_path="/root/ocean-nodes"

# 检查文件夹是否存在
if [ ! -d "$folder_path" ]; then
  echo "输入的路径无效，请重新运行脚本并提供正确的路径。"
  exit 1
fi

# 获取VPS的公网IP
vps_ip=$(curl -s ifconfig.me)

# 如果无法获取公网IP，退出脚本
if [ -z "$vps_ip" ]; then
  echo "无法获取VPS的公网IP。"
  exit 1
fi

# 设置输出文件名为VPS公网IP命名的文件
output_file="${vps_ip}.txt"

# 清空文件内容
> "$output_file"

# 查找所有名为 private_key 的文件并将它们的内容添加到 output_file
find "$folder_path" -type f -name "private_key" | while read private_key_file; do
  if [ -f "$private_key_file" ]; then
    echo "正在处理: $private_key_file"
    cat "$private_key_file" >> "$output_file"  # 追加文件内容，不插入空白行
  fi
done

# 完成提示
echo "所有 private_key 已归集到文件: $output_file"
