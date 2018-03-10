from flask import Flask

app = Flask(__name__)

@app.route('/')
def f():
    return 'lel rip'

app.run(port=6464)
