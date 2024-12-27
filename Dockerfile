# Use the official Python 3.8 slim image as a base
FROM python:3.8-slim

# Set environment variables
ENV PIP_NO_CACHE_DIR=1

# Install essential dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    bash \
    curl \
    git \
    libffi-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libpq-dev \
    python3-lxml \
    python3-psycopg2 \
    python3-pip \
    python3-requests \
    python3-sqlalchemy \
    python3-tz \
    python3-aiohttp \
    postgresql \
    postgresql-client \
    ffmpeg \
    zlib1g \
    libssl-dev \
    libgconf-2-4 \
    libxi6 \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pip packages
RUN pip3 install --upgrade pip setuptools wheel

# Clone the bot repository
RUN git clone https://github.com/AnonymousX1025/FallenRobot /root/FallenRobot

# Set the working directory to the bot
WORKDIR /root/FallenRobot

# Copy config.py (make sure to place it in the right directory)
COPY ./FallenRobot/config.py /root/FallenRobot/FallenRobot/

# Show the contents of the directory to ensure requirements.txt is present
RUN ls -l /root/FallenRobot

# Install Python dependencies and add verbose output to help debug
RUN pip3 install -U -r requirements.txt --no-cache-dir --verbose

# Set environment variables (configure these in Railway)
ENV PATH="/home/bot/bin:$PATH"

# Expose the necessary port (if webhooks or web interfaces are used)
EXPOSE 5000

# Set the command to start the bot
CMD ["python3", "-m", "FallenRobot"]
