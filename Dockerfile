FROM python:3.11-slim

RUN apt update && apt install -y --no-install-recommends nginx supervisor && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .
COPY templates/ ./templates/

# Copy configurations
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

#Start supervisor: 
CMD ["supervisord", "-c", "/etc/supervisord/conf.d/supervisord.conf"]