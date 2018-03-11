from memnet import Memnet

from flask import Flask, request, jsonify
import urllib
import cv2
from skimage.measure import compare_ssim
import glob

app = Flask(__name__)
model = Memnet()

#list_pics = glob.glob('./app/images/*.jpg')

@app.route('/')
def f():
    return 'App'

@app.route('/score', methods = ['POST'])
def caclulate_score():
    image_link = request.form['data']
    print(image_link)
    urllib.urlretrieve(image_link, "image.jpg")

    return jsonify(model.calculate_memorability('./image.jpg'))

@app.route('/compare', methods = ['POST'])
def compare_photos():
    data = request.form['data']

    # TODO: Fix this implementation
    for i in xrange(len(pics)):
        for j in xrange(i + 1, len(pics)):
            if i < len(pics) and j < len(pics):
                imageA = cv2.imread(pics[i])
                imageB = cv2.imread(pics[j])

                grayA = cv2.cvtColor(imageA, cv2.COLOR_BGR2GRAY)
                grayB = cv2.cvtColor(imageB, cv2.COLOR_BGR2GRAY)

                score, _ = compare_ssim(grayA, grayB, full=True)

                if score > 0.3: # pictures are similar
                    pics.pop(j)

    return pics

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
