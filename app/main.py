from memnet import Memnet

from flask import Flask, request, jsonify
import urllib
import cv2
from skimage.measure import compare_ssim
import glob

app = Flask(__name__)
model = Memnet()
hardcoded_images = ['https://i.pinimg.com/originals/62/20/d2/6220d255154fad0c911a3cb4c0072031.jpg',
                   'https://i.pinimg.com/originals/8b/a1/01/8ba101bc0e6fb061e79bef8c7bac97cc.jpg']
code_verified = {}
code_to_token = {}
code_to_images = {}
score_cache = {}

@app.route('/get_mode')
def get_mode():
    code = request.args.get('code')

    if code not in code_verified or not code_verified[code]:
        code_verified[code] = False
        resp = jsonify('verify')
    else:
        resp = jsonify('photos')

    resp.headers.add('Access-Control-Allow-Origin', '*')
    return resp

@app.route('/get_images', methods = ['POST'])
def get_images():
    code = request.form['code']
    code_to_images[code] = hardcoded_images

    for image in code_to_images[code]:
        if image not in score_cache:
            score_cache[image] = calculate_score(image)

    resp = jsonify({
		'images': [image for image in code_to_images[code] if score_cache[image] > 0.8]
	})
    resp.headers.add('Access-Control-Allow-Origin', '*')

    return resp

def caclulate_score(image_link):
    image_link = request.form['data']
    urllib.urlretrieve(image_link, "image.jpg")

    return model.calculate_memorability('./image.jpg')

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

@app.route('/code_verified', methods = ['POST']) # Received from phone
def code_exists():
    print(request.form)
    code = request.form['code']
    print(code)

    if code in code_verified:
        code_verified[code] = True
        return jsonify(1)
    else:
        return jsonify(-1)

@app.route('/token', methods = ['POST']) # Received from phone
def store_token():
    code = request.form['code']
    token = request.form['token']

    code_to_token[code] = token

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
