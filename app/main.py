from memnet import Memnet

from flask import Flask
import glob

app = Flask(__name__)

model = Memnet()

list_pics = glob.glob('./app/images/*.jpg')
print(list_pics)

for pic in list_pics:
    print("Pic: {} with memorability: {}".format(pic, model.calculate_memorability(pic)))

@app.route('/')
def f():
    return 'np'

app.run(host='0.0.0.0', port=80)
