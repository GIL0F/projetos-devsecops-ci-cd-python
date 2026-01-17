FROM python:3.11-alpine

# Create non-root user
RUN adduser -D appuser
WORKDIR /app

# Copy requirements first
COPY app/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Switch to non-root user
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
