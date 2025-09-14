#!/usr/bin/env bash

# 获取活跃输出设备
wpctl_output=$(wpctl status | grep '\*')

# 活跃输出
sink_line=$(echo "$wpctl_output" | grep -i -m1 'vol')
vol_raw=$(echo "$sink_line" | grep -oE 'vol: [0-9\.]+' | awk '{print $2}')

# 是否 muted？
if echo "$sink_line" | grep -q "MUTED"; then
  vol_display="静音"
else
  # 小数转百分比，带 %
  vol=$(printf "%.0f" "$(echo "$vol_raw * 100" | bc -l)")
  vol_display="${vol}%"
fi

# 有蓝牙输入？
if echo "$wpctl_output" | grep -q 'bluez_input'; then
  device_name=$(echo "$sink_line" | sed -E 's/.*[0-9]+\.\s+(.+)\[vol:.*/\1/' | xargs)
  mac=$(echo "$wpctl_output" | grep 'bluez_input' | grep -oE '([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}' | head -n1)
  batt_raw=$(bluetoothctl info "$mac" | grep "Battery Percentage" | awk '{print $3}')
  
  # 转换电量值（去掉 0x 前缀）
  if [[ "$batt_raw" =~ ^0x ]]; then
    batt=$(( batt_raw ))
  else
    batt=${batt_raw%\%}
  fi
  
  echo "%{F#FF69B4} %{F-}$device_name${batt}% %{F#aaff77} %{F-} ${vol_display}"
else
  echo "%{F#aaff77} %{F-} $vol_display"
fi

