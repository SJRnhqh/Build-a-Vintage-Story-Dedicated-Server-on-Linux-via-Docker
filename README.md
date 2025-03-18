# 通过 Docker 在 Linux 中搭建 Vintage Story 专用服务器  
# Build a Vintage Story Dedicated Server on Linux via Docker

[![GitHub Repository](https://img.shields.io/badge/GitHub-Repository-blue?style=flat-square&logo=github)](https://github.com/SJRnhqh/Build-a-Vintage-Story-Dedicated-Server-on-Linux-via-Docker.git)  
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

本项目旨在通过 Docker 技术，帮助用户在 Linux 系统中快速搭建并管理 **Vintage Story 专用服务器（Dedicated Server）**。Vintage Story 是一款以生存和探索为核心的沙盒游戏，其专用服务器支持多人联机，通过容器化部署，您可以轻松实现服务器的搭建、配置、备份和扩展，而无需担心环境依赖问题。

This project aims to help users quickly set up and manage a **Vintage Story Dedicated Server** on Linux systems via Docker. Vintage Story is a sandbox game focused on survival and exploration, and its dedicated server supports multiplayer. By containerizing the deployment, you can easily build, configure, backup, and scale the server without worrying about environment dependencies.

---

## 项目特点 / Features

- **快速部署**：通过 Docker 镜像，一键完成 Vintage Story 专用服务器的搭建。  
  **Quick Deployment**: Set up the Vintage Story dedicated server with one click using Docker images.  
- **环境隔离**：Docker 容器确保服务器运行环境与主机隔离，避免冲突。  
  **Environment Isolation**: Docker containers ensure the server runs in an isolated environment, avoiding conflicts.  
- **易于管理**：支持容器自启动、定期备份和配置文件热更新。  
  **Easy Management**: Supports container auto-start, periodic backups, and hot updates of configuration files.  
- **跨平台兼容**：基于 Docker 的部署方式，支持多种 Linux 发行版。  
  **Cross-Platform Compatibility**: Docker-based deployment supports multiple Linux distributions.  

---

## 适用场景 / Use Cases

- 个人或团队搭建 Vintage Story 专用服务器，支持多人联机。  
  For individuals or teams to set up a Vintage Story dedicated server for multiplayer.  
- 快速测试和开发 Vintage Story 游戏模组。  
  For quickly testing and developing Vintage Story game mods.  
- 学习 Docker 和容器化技术的实践项目。  
  As a hands-on project for learning Docker and containerization.  

---

## 快速开始 / Quick Start

只需按照以下步骤操作，即可在 Linux 中快速搭建 Vintage Story 专用服务器：  
Follow the steps below to quickly set up a Vintage Story dedicated server on Linux:

1. **克隆本项目到本地**  
   **Clone this project to your local machine**  
   ```bash
   git clone https://github.com/SJRnhqh/Build-a-Vintage-Story-Dedicated-Server-on-Linux-via-Docker.git
   cd Build-a-Vintage-Story-Dedicated-Server-on-Linux-via-Docker
   ```

2. **构建 Docker 镜像**  
   **Build the Docker image**  
   ```bash
   docker build -t vintage-story-server .
   ```

3. **创建数据文件夹并挂载**  
   **Create the data folder and mount it**  
   在主机上创建 `/var/vintagestory/data` 文件夹，用于挂载容器中的所有服务器数据（包括日志、世界存档、配置文件等）：  
   Create the `/var/vintagestory/data` folder on the host to mount all server data (including logs, world saves, configuration files, etc.) from the container:  
   ```bash
   sudo mkdir -p /var/vintagestory/data
   sudo chmod -R 777 /var/vintagestory/data
   ```

4. **自定义服务器内容（可选）**  
   **Customize server content (optional)**  
   - **添加模组**：将模组文件（`.dll` 或 `.zip`）放入 `/var/vintagestory/data/Mods` 文件夹。  
     **Add mods**: Place mod files (`.dll` or `.zip`) in the `/var/vintagestory/data/Mods` folder.  
     ```bash
     mkdir -p /var/vintagestory/data/Mods
     cp /path/to/your/mod.zip /var/vintagestory/data/Mods/
     ```
   - **添加存档**：将存档文件夹放入 `/var/vintagestory/data/Saves` 文件夹。  
     **Add saves**: Place save folders in the `/var/vintagestory/data/Saves` folder.  
     ```bash
     mkdir -p /var/vintagestory/data/Saves
     cp -r /path/to/your/save /var/vintagestory/data/Saves/
     ```
   - **修改服务器配置**：编辑 `/var/vintagestory/data/serverconfig.json` 文件，自定义服务器设置和世界生成参数。  
     **Modify server configuration**: Edit the `/var/vintagestory/data/serverconfig.json` file to customize server settings and world generation parameters.  
     ```bash
     nano /var/vintagestory/data/serverconfig.json
     ```

5. **运行 Docker 容器**  
   **Run the Docker container**  
   使用以下命令运行容器，并将主机上的 `/var/vintagestory/data` 挂载到容器中的 `/var/vintagestory/data`。同时，使用 `--restart=always` 参数确保容器在意外停止或系统重启后自动启动：  
   Run the container and mount the `/var/vintagestory/data` folder from the host to the container. Additionally, use the `--restart=always` parameter to ensure the container auto-starts after unexpected stops or system reboots:  
   ```bash
   docker run -it \
     --name vintage-story-server \
     -p 42420:42420 \
     -v /var/vintagestory/data:/var/vintagestory/data \
     --restart=always \
     vintage-story-server
   ```
   ```bash
   ./server.sh start
   ```

6. **使用 `start.sh` 脚本**  
   **Use the `start.sh` script**  
   本项目已包含一个 `start.sh` 脚本，用于备份存档、删除旧备份并启动服务器。请根据自身情况修改脚本内容（例如容器名称、存档路径等），然后运行脚本：  
   This project includes a `start.sh` script to back up saves, delete old backups, and start the server. Modify the script content (e.g., container name, save path, etc.) according to your needs, then run the script:  
   ```bash
   # 修改脚本内容（如果需要）
   nano start.sh

   # 运行脚本
   chmod +x start.sh
   ./start.sh
   ```

7. **设置 crontab 任务（可选）**  
   **Set up crontab task (optional)**  
   如果需要服务器在系统重启时自动启动，可以将 `start.sh` 脚本添加到 `crontab` 中：  
   If you want the server to start automatically on system reboot, add the `start.sh` script to `crontab`:  
   ```bash
   (crontab -l 2>/dev/null; echo "@reboot $(pwd)/start.sh") | crontab -
   ```
   注意：确保 `start.sh` 脚本路径正确，并根据需要调整脚本内容。  
   Note: Ensure the `start.sh` script path is correct and adjust the script content as needed.

---
