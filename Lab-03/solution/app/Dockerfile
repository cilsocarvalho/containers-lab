FROM python:3.12-slim
WORKDIR /app
RUN groupadd -r app && useradd -r -g app app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
USER app
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/health')" || exit 1
CMD ["gunicorn","--bind","0.0.0.0:8000","app:app"]
