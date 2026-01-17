FROM python:3.11-alpine

ARG CACHE_BUSTER=$(date +%s)
ENV CACHE_BUSTER=${CACHE_BUSTER}

RUN adduser -D appuser
WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir --upgrade pip==24.0

RUN echo "=== CONTEÚDO DO requirements.txt ===" && cat requirements.txt

RUN pip install --no-cache-dir \
    flask==3.0.0 \
    requests==2.31.0 \
    jaraco.context==6.1.0

RUN pip list | grep -i jaraco

COPY app/ .

USER appuser
EXPOSE 5000

CMD ["python", "app.py"]
