FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONBUFFERED=1

RUN apt-get update && apt-get install -y \
	libpd-dev \
	git \
	curl \
	python3-dev \
	python3-venv \
	python3-pip \
	build-essential \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/requirements.txt

RUN pip3 install -r requirements.txt 

COPY . .

CMD ["gunicorn", "saas.wsgi:application", "--bind", "0.0.0.0:8000"]


