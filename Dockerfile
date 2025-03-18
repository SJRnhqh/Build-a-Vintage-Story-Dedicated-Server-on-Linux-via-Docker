# 使用官方 .NET 7 运行时镜像作为基础镜像
FROM mcr.microsoft.com/dotnet/runtime:7.0

# 设置工作目录
WORKDIR /home/vintagestory/server

# 安装依赖
RUN apt-get update && apt-get install -y \
    unzip \
    procps \
    screen \
    micro \
    && rm -rf /var/lib/apt/lists/*

# 创建 vintagestory 用户
RUN useradd -m vintagestory

# 复制本地的压缩包到镜像
COPY vs_server_linux-x64_1.20.*.tar.gz .

# 解压压缩包
RUN tar xzf vs_server_linux-x64_*.*.*.tar.gz && \
	chmod +x server.sh && \
    rm vs_server_linux-x64_1.20.*.tar.gz && \
    mkdir -p /var/vintagestory/data/Logs

#启动服务器
RUN ./server.sh start

# 设置文件权限
RUN chown -R vintagestory:vintagestory . && \
	chown -R vintagestory:vintagestory /var/vintagestory/data

# 暴露端口
EXPOSE 42420

CMD ["/bin/bash"]
