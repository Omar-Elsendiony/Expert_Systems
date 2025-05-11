#!/usr/bin/python3
""" Flask Application """
#################### flask imports ###########################################################
# import requests
import json
from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
from pyswip import Prolog
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
    print(features)
    # Log received data for debugging
    # print("Algorithm:", algorithm)
    # print("Chaining:", chaining)
    # print("Features:", features)

    features['fruit spots'] = features['fruit-spots']
    del features['fruit-spots']

    features['external decay'] = features['external-decay']
    del features['external-decay']
    
    features_indexed = {
        k: -1 if v == '?' else attribute_name_values[k].index(v)
        for k, v in features.items()
    }
    prolog = Prolog()
    prolog.consult("rules/rules_dt_prolog.pl")
    
    features = []
    for k, v in features_indexed.items():
        features.append(f'feature(\'{k}\', {v})')
    features_str = ', '.join(features)
    prolog_response = prolog.query(f"classify([{features_str}], Category, RuleID).")
    res = ""
    for soln in prolog_response:
        res = soln['Category']
        res = res.replace("\"", "").replace('\n','')
        rule_id = soln['RuleID']
        print(f"Rule {rule_id} fired → Prediction: {res}")
    
    # TODO: Run your diagnosis logic here using the input data
    # Dummy result for demonstration
    result = {
        "disease": res,
        "confidence": "92%",
        "interpretation": "The reasons for the diagnosis are as follows: ...",
    }

    return jsonify(result), 200


""" Calling the main function """

if __name__ == "__main__":
    """ Main Function """
    host = '0.0.0.0'
    port = '5000'
    app.run(host=host, port=port, threaded=True, debug=True)
