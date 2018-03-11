from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/')
def f():
    return 'np'

@app.route("/mode")
def g():
	# Return verify or photos
	return "verify"

@app.route("/code")
def h():
	# Return verify or photos
	return "999 136"


@app.route("/get_images")
def a():
	sample_data = {
		"images": [
			{ "img": "",
			 "alt": "",
			},
			{ "img": "",
			 "alt": "",
			}
			
		]}
	return jsonify(sample_data)

if __name__ == "__main__":
	app.run(host='0.0.0.0', port=80)