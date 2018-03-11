from memnet import Memnet
from collections import defaultdict

from flask import Flask, request, jsonify
import urllib
import requests
import json
import cv2
from skimage.measure import compare_ssim
import glob

app = Flask(__name__)
model = Memnet()
code_to_token = {}
code_to_images = defaultdict(lambda: [])
score_cache = {}

@app.route('/get_mode')
def get_mode():
    code = request.args.get('code')

    if code not in code_to_token:
        resp = jsonify('verify')
        print("Verify stage")
    else:
        resp = jsonify('photos')

    resp.headers.add('Access-Control-Allow-Origin', '*')
    return resp

@app.route('/get_images')
def get_images():
    global code_to_images
    global code_to_token
    global score_cache
    code = request.args.get('code')

    token = code_to_token[code]
    albums = json.loads(requests.get('https://graph.facebook.com/me/albums?access_token={}'.format(token)).content)
    albums = [data['id'] for data in albums['data']]

    for album in albums:
        code_to_images[code] += [data['images'][0]['source'] for data in json.loads(requests.get('https://graph.facebook.com/photos?id={}&fields=images&access_token={}'.format(album, token)).content)['data']]
    for image in code_to_images[code]:
        if image not in score_cache:
            score_cache[image] = calculate_score(image)
    resp = jsonify({
        'images': [image for image in code_to_images[code] if score_cache[image] > 0.8]
    })
    resp.headers.add('Access-Control-Allow-Origin', '*')
    return resp

def calculate_score(image_link):
    urllib.urlretrieve(image_link, "image.jpg")

    return model.calculate_memorability('./image.jpg')

@app.route('/code_verified', methods = ['POST']) # Received from phone
def code_exists():
    code = json.loads(request.form.to_dict().keys()[0])['code']
    return jsonify(1)


@app.route('/store_token', methods = ['POST']) # Received from phone
def store_token():
    code = json.loads(request.form.to_dict().keys()[0])['code']
    token = json.loads(request.form.to_dict().keys()[0])['token']

    code_to_token[code] = token

    return json.dumps({'success': True}), 200, {'ContentType': 'application/json'}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
