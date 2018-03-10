from flask import Flask

app = Flask(__name__)

@app.route('/')
def f():
    return 'lel rip'

app.run(debug=True, port=80, host="0.0.0.0")
