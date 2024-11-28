# Utiliza la imagen oficial de Python como base
FROM python:3.11-slim

# Establece variables de entorno
ENV PYTHONUNBUFFERED=1

# Establece el directorio de trabajo en /app
WORKDIR /app

# install dependencies
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN apt install -y build-essential libpcre3 libpcre3-dev vim python3-dev libpq-dev

# Copia el archivo de requisitos al directorio de trabajo
COPY requirements.txt /app/

# Instala las dependencias necesarias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de la aplicación al contenedor
COPY . /app/

# Expone el puerto en el que correrá la aplicación
EXPOSE 8000

# Comando para ejecutar la aplicación utilizando Gunicorn
# CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
