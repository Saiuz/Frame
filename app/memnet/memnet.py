import caffe
import numpy as np

class Memnet(object):
    def __init__(self):
        self.network = caffe.Net('./app/memnet/deploy.prototxt',
                                 './app/memnet/memnet.caffemodel',
                                 caffe.TEST)

        self._mu = np.load('/opt/caffe/python/caffe/imagenet/ilsvrc_2012_mean.npy')
        self._mu = self._mu.mean(1).mean(1)

        self._create_transformer()

    def _create_transformer(self):
        self.transformer = caffe.io.Transformer({'data': self.network.blobs['data'].data.shape})

        self.transformer.set_transpose('data', (2, 0, 1))
        self.transformer.set_mean('data', self._mu)
        self.transformer.set_raw_scale('data', 255)
        self.transformer.set_channel_swap('data', (2, 1, 0))

    def calculate_memorability(self, image):
        image_i = caffe.io.load_image(image)
        transformed_image_i = self.transformer.preprocess('data', image_i)
        self.network.blobs['data'].data[...] = transformed_image_i

        output_i = self.network.forward()

        return output_i.values()[0][0].tolist()[0]
