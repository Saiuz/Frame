FROM bvlc/caffe:cpu
RUN pip install flask
COPY app /app
#WORKDIR /app
EXPOSE 6464
#ENTRYPOINT ["python main.py"]
