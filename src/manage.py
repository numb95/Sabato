from flask import Flask, jsonify
import config
import requests
from healthcheck import nodes

app = Flask(__name__)

@app.route('/healthcheck/slave')
def slave_health():
    return jsonify(nodes.slave_status())
@app.route('/healthcheck/master')
def master_health():
    return jsonify(nodes.master_status())



if __name__ == "__main__":
    app.run(debug=True)