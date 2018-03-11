FROM bvlc/caffe:cpu
RUN pip install flask
RUN pip install bottle
RUN pip install scikit-image
RUN pip install opencv-python

COPY app /app
#WORKDIR /app
#ENTRYPOINT ["python main.py"]
