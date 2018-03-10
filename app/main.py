from flask import Flask

app = Flask(__name__)

@app.route('/')
def f():
    return 'lel rip'

app.run(debug=True, host='0.0.0.0', port=6464)
