# Docker File 

FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN pip install --upgrade pip

WORKDIR /usr/src/app

COPY requirements.txt .

# Install libraries and disable caching in container
RUN  pip install --no-cache-dir -r requirements.txt

# Copy project code
COPY . .  

# Migrate database
# RUN  django-admin startproject proX .


EXPOSE 8000

# Creating non-root user and giving permissions 
RUN useradd -ms /bin/bash app
RUN chown -R app:app /usr/src/app
USER app

RUN  python manage.py migrate

RUN echo "Applying data migration"

#Bind Django to all interfaces:
CMD python manage.py runserver 0.0.0.0:8000
