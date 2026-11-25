from fastapi import FastAPI

from app.alertas import fuera_de_rango

app = FastAPI(title="API Incubación")


@app.get("/incubadoras/{incubadora_id}/estado")
def estado(incubadora_id: int, temp: float):
    return {"incubadora": incubadora_id, "temp": temp, "alerta": fuera_de_rango(temp)}
