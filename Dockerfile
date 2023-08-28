FROM python:3.9

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app/src /code/app

ENV UVICORN_PORT=80

ENV UVICORN_HOST=0.0.0.0

CMD ["uvicorn", "app.main:app", "--proxy-headers"]