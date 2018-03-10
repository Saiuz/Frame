FROM python:latest

RUN pip install flask
COPY app /app
WORKDIR /app
#ENTRYPOINT ["python main.py"]

