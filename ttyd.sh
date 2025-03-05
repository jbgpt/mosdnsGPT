#!/bin/sh

# 创建保存路径的脚本
cat << 'EOF' > /etc/save_path.sh
#!/bin/sh

# Path to store the last directory
LAST_DIR_FILE="/etc/last_dir"

# Function to save the current directory
save_dir() {
    echo "$(pwd)" > $LAST_DIR_FILE
}

# Function to restore the last directory
restore_dir() {
    if [ -f $LAST_DIR_FILE ]; then
        cd "$(cat $LAST_DIR_FILE)"
    fi
}

# Trap the EXIT signal to save the directory when the shell exits
trap save_dir EXIT

# Restore the last directory when the shell starts
restore_dir

# Start an interactive shell
exec "$SHELL"
EOF

# 确保脚本是可执行的
chmod +x /etc/save_path.sh

# 启动 ttyd 并传递保存路径的脚本
ttyd -t titleFixed=ash -- /bin/sh /etc/save_path.sh
