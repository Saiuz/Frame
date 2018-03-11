from flask import Flask, jsonify
import requests

GCLOUD_SERVER = 'http://35.230.80.120:8080'

app = Flask(__name__)
verification_required = True

@app.route('/')
def f():
    return 'Raspberry Pi App running'

@app.route('/mode')
def get_status():
	global verification_required

	# Return verify or photos
	resp = 'verify' if verification_required else 'photos'
	resp = jsonify(resp)
	resp.headers.add('Access-Control-Allow-Origin', '*')

	if verification_required:
		verification_required = False
	return resp

@app.route('/code')
def get_code():
	resp = jsonify('999 136')
	resp.headers.add('Access-Control-Allow-Origin', '*')

	return resp

@app.route('/get_images')
def get_images():
    images = ['https://i.pinimg.com/originals/62/20/d2/6220d255154fad0c911a3cb4c0072031.jpg',
              'https://i.pinimg.com/originals/8b/a1/01/8ba101bc0e6fb061e79bef8c7bac97cc.jpg']

    resp = jsonify({
		'images': [image for image in images if float(requests.post(GCLOUD_SERVER + '/score', data={'data': image}).content) > 0.8]
	})
    resp.headers.add('Access-Control-Allow-Origin', '*')

    return resp

if __name__ == '__main__':
    try:
    	app.run(host='0.0.0.0', port=8080)
    except:
    	app.run(port=8080)
