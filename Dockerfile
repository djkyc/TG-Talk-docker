FROM python:3.11-slim AS base

WORKDIR /app

# 安装最基础运行依赖（无 gcc）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

# 安装 python 依赖
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
        python-telegram-bot==20.7 \
        python-dotenv

# 将所有项目文件复制进去
COPY . .

# 数据目录
RUN mkdir -p /app/data

ENV PYTHONUNBUFFERED=1 \
    TG_BOT_DATA_DIR=/app/data

CMD ["python", "host_bot.py"]
