#!/usr/bin/python3
""" Flask Application """
#################### flask imports ###########################################################
# import requests
from os import environ
import json
from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
from hashlib import md5
##########################################################################################

app = Flask(__name__ , static_url_path='')
cors = CORS(app)


with open('rules/attribute_name_values.json', 'r') as f:
    attribute_name_values = json.load(f)


@app.route('/', strict_slashes=False, methods=["POST", "GET"])
def main():
    return render_template('main.html')


@app.route('/diagnose', strict_slashes=False, methods=["POST", "GET"])
def diagnose():
    print("Diagnose request received")

    # Parse JSON data from request
    data = request.get_json()
    algorithm = data.get('algorithm')
    chaining = data.get('chaining')
    features = data.get('features')

    # Log received data for debugging
    # print("Algorithm:", algorithm)
    # print("Chaining:", chaining)
    # print("Features:", features)

    features_indexed = {k: v for k, v in features.items() if k in attribute_name_values}

    # TODO: Run your diagnosis logic here using the input data
    # Dummy result for demonstration
    result = {
        "disease": "Flu",
        "confidence": "92%",
        "recommendation": "Stay hydrated and get plenty of rest"
    }

    return jsonify(result), 200


""" Calling the main function """

if __name__ == "__main__":
    """ Main Function """
    host = '0.0.0.0'
    port = '5000'
    app.run(host=host, port=port, threaded=True, debug=True)
