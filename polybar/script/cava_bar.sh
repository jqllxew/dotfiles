#!/usr/bin/env bash

# 启动 cava 并持续读取输出
cava | while read -r line; do
  if [[ ! "$line" =~ [^0\;] ]]; then
    echo ""
    continue  # 全零，不输出
  fi
  # 用 IFS 分割成数组
  IFS=';' read -ra bars <<< "$line"

  bar_str=""
  for i in "${bars[@]}"; do
    case $i in
      0) bar="  " ;;
      1) bar="▂" ;;
      2) bar="▃" ;;
      3) bar="▄" ;;
      4) bar="▅" ;;
      5) bar="▆" ;;
      6) bar="▇" ;;
      7|8) bar="█" ;;  # 因为ascii_max_range=8，所以也要加 8
      *) bar="  " ;;
    esac

    # 动态分段颜色
    if [[ $i -le 2 ]]; then
      color="#69E8FF"   # 低能量：蓝
    elif [[ $i -le 5 ]]; then
      color="#F0C674"   # 中能量：黄
    else
      color="#FF69B4"   # 高能量：粉
    fi

    bar_str+="%{F${color}}${bar}%{F-}"
  done

  echo "$bar_str"
done
