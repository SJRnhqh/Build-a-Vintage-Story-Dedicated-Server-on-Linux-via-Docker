#!/bin/bash

# 定义备份目录和存档路径 / Define backup directory and save file path
BACKUP_DIR="/var/vintagestory/data/BackupSaves"
SAVE_FILE="/var/vintagestory/data/Saves/default.vcdbs"

# 停止服务器 / Stop the server
docker exec vintage-story-server /bin/bash server.sh stop

# 创建备份目录（如果不存在） / Create backup directory (if it doesn't exist)
docker exec vintage-story-server mkdir -p "$BACKUP_DIR"

# 生成基于时间的备份文件名 / Generate a timestamp-based backup file name
BACKUP_FILE="$BACKUP_DIR/default_$(date +%Y%m%d_%H%M%S).vcdbs.bak"

# 复制存档文件到备份目录 / Copy the save file to the backup directory
docker exec vintage-story-server cp "$SAVE_FILE" "$BACKUP_FILE"

# 删除超过10个的旧备份文件 / Delete old backup files (keep the latest 10)
docker exec vintage-story-server /bin/bash -c "ls -t $BACKUP_DIR/default_*.vcdbs.bak | tail -n +11 | xargs rm -f"

# 启动服务器 / Start the server
docker exec vintage-story-server /bin/bash server.sh start
