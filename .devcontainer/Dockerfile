FROM mcr.microsoft.com/devcontainers/python:1-3.12-bookworm
# La imagen base trae un repositorio apt de yarn con la llave vencida: rompe `apt-get update`
# (y con eso la instalación de Docker). No usamos yarn en el curso, así que se elimina.
RUN rm -f /etc/apt/sources.list.d/yarn.list
