from fastapi.testclient import TestClient

from app.alertas import fuera_de_rango
from app.main import app


def test_sin_alerta_en_rango_normal():
    assert fuera_de_rango(37.5) is False


def test_alerta_si_temperatura_alta():
    assert fuera_de_rango(38.4) is True


def test_endpoint_devuelve_alerta():
    r = TestClient(app).get("/incubadoras/7/estado", params={"temp": 36.1})
    assert r.status_code == 200
    assert r.json()["alerta"] is True
