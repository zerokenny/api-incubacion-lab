# Rango operativo de temperatura para incubación (°C)
TEMP_MIN = 37.2
TEMP_MAX = 37.9


def fuera_de_rango(temp: float) -> bool:
    """True si la lectura de la incubadora debe generar alerta."""
    return not (TEMP_MIN <= temp <= TEMP_MAX)
