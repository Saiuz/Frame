FROM python:latest
RUN pip install flask
COPY pi_server.py /pi_server.py
WORKDIR /
CMD ["python"]
ENTRYPOINT  ["pi_server.py"]
