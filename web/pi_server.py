from flask import Flask, jsonify
app = Flask(__name__)
verification_requred = True

@app.route('/')
def f():
    return 'Raspberry Pi App running'

@app.route('/mode')
def get_status():
	# Return verify or photos
	return 'verify' if verification_requred else 'photos'

@app.route('/code')
def get_code():
	return '999 136'


@app.route('/get_images')
def get_images():
	sample_data = {
		'images': [
            {
                'img': 'https://i.pinimg.com/originals/62/20/d2/6220d255154fad0c911a3cb4c0072031.jpg'
			},
			{
                'img': 'https://i.pinimg.com/originals/8b/a1/01/8ba101bc0e6fb061e79bef8c7bac97cc.jpg'
			}
		]
    }

	return jsonify(sample_data)

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=8080)
