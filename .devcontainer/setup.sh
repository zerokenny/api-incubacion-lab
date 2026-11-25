#!/usr/bin/env bash
# Se ejecuta una vez al crear el Codespace. Debe ser idempotente y no fallar por cosas opcionales.
set -uo pipefail

echo "==> Dependencias de Python"
pip install --no-cache-dir -r requirements.txt

# pip instala los scripts (pytest, uvicorn) en ~/.local/bin; que cualquier terminal los encuentre
grep -q '.local/bin' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo "==> Espejo de Docker Hub (evita el límite de pulls anónimos: los Codespaces comparten IPs)"
# mirror.gcr.io cachea las imágenes oficiales de Docker Hub (python, nginx, postgres...).
sudo mkdir -p /etc/docker
echo '{ "registry-mirrors": ["https://mirror.gcr.io"] }' | sudo tee /etc/docker/daemon.json >/dev/null
sudo pkill -HUP dockerd || echo "(aviso) no se pudo recargar dockerd; el espejo no quedó activo"

echo "==> Verificación"
python --version
docker --version
docker compose version
gh --version | head -1
aws --version
echo "Listo. Prueba: pytest -q   y   docker build -t api-incubacion:1.0 ."
