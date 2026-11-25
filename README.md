# Demo · API Incubación (clase modelo Contenedores + CI)

```bash
docker build -t api-incubacion:1.0 .
docker run -d -p 8000:8000 --name incub-01 api-incubacion:1.0
docker ps
curl "localhost:8000/incubadoras/7/estado?temp=38.4"   # {"alerta": true}
docker exec incub-01 pytest -q                          # 3 passed
docker stop incub-01 && docker rm incub-01
```

Simular el fallo del pipeline (límite subido a 38,5 °C):

```bash
sed 's/TEMP_MAX = 37.9/TEMP_MAX = 38.5/' app/alertas.py > /tmp/alertas_bug.py
docker run --rm -v /tmp/alertas_bug.py:/app/app/alertas.py:ro api-incubacion:1.0 pytest -q   # 1 failed
```

El workflow de CI está en `.github/workflows/ci.yml` (GitHub Actions).
