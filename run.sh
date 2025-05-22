#!/bin/bash
timestamp=$(date "+%Y_%m_%d_%H_%M_%S")

# 建立 logs 資料夾（若不存在）
mkdir -p ./logs

# 取得目前時間作為 log 檔案名稱
logfile="./logs/$timestamp.log"

echo "========== $(date) ==========" >> "$logfile"

# 1. Kill 掉之前的 node app.js / ngrok / n8n 程序
echo "Killing previous processes..." >> "$logfile"
pkill -f "node app.js"
pkill -f "ngrok http"
pkill -f "n8n"

# 2. 背景執行 node app.js
echo "Starting node app.js..." >> "$logfile"
nohup node app.js >> "$logfile" 2>&1 &

# 3. 背景執行 ngrok
echo "Starting ngrok..." >> "$logfile"
nohup ngrok http 3000 >> "$logfile" 2>&1 &

# 4. 背景執行 n8n
echo "Starting n8n..." >> "$logfile"
nohup n8n >> "$logfile" 2>&1 &

echo "All processes started. Logs saved to $logfile"

