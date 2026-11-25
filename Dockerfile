# 1. Base: Python fijo, imagen ligera
FROM python:3.12-slim
WORKDIR /app
# 2. Dependencias (se cachean)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# 3. Código de la aplicación
COPY app/ ./app
COPY tests/ ./tests
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
