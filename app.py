#!/usr/bin/python3
""" Flask Application """
#################### flask imports ###########################################################
# import requests
import json
from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
from pyswip import Prolog
import re
##########################################################################################
import os
# from Algorithms.decision_tree import decision_tree_backward, decision_tree_forward
os.environ['PATH'] = f"/usr/bin/swipl:{os.environ['PATH']}"


app = Flask(__name__ , static_url_path='')
cors = CORS(app)


with open('attribute_values_mapping/attribute_name_values.json', 'r') as f:
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
    # print("Features:", type(features))
    algorithm_name_technique_mapping = {
        "ID3": "decision_tree",
        "CN2": "covering",
        "Apriori": "association",
    }
    
    algorithm = algorithm_name_technique_mapping.get(algorithm, algorithm)
    if (algorithm == "decision_tree"):
        if (chaining == "backward"):
            result = backward(features, attribute_name_values)
        elif (chaining == "forward"):
            result = forward(features, attribute_name_values, algorithm="decision_tree")
        else:
            result = {
                "disease": "No Result",
            }   
        return jsonify(result), 200
    elif (algorithm == "covering"):
        if (chaining == "backward"):
            result = backward(features, attribute_name_values)
        elif (chaining == "forward"):
            result = forward(features, attribute_name_values, algorithm="covering")
        else:
            result = {
                "disease": "No Result",
            }
        return jsonify(result), 200
    elif (algorithm == "association"):
        if (chaining == "backward"):
            result = backward(features, attribute_name_values)
        elif (chaining == "forward"):
            result = forward(features, attribute_name_values, algorithm="association")
        else:
            result = {
                "disease": "No Result",
            }
        return jsonify(result), 200
    

    result = {
        "disease": "No disease",
    }
    return jsonify(result), 200


def forward(features, attribute_name_values, algorithm="decision_tree"):
    """ Decision Tree """
    from clips import Environment  # Import here to ensure fresh instance per test case
    env = Environment()
    env.clear()  # fully resets the environment
    if algorithm == "decision_tree":
        learned_rules_file = "learned_dt_rules.txt"
        algorithm_clips = "rules_dt_CLIPS.clp"
    elif algorithm == "covering":
        learned_rules_file = "learned_CN2_rules.txt"
        algorithm_clips = "rules_CN2_CLIPS.clp"
    elif algorithm == "association":
        learned_rules_file = "learned_rules_apriori.txt"
        algorithm_clips = "rules_Apriori_CLIPS.clp"
    
    print(f"Algorithm: {algorithm}")
    print(f"Learned Rules File: {learned_rules_file}")
    env.load(f'declarative_rules/{algorithm_clips}')
    env.reset()
    res = None
    
    features['fruit spots'] = features['fruit-spots']
    del features['fruit-spots']

    features['external decay'] = features['external-decay']
    del features['external-decay']

    features_indexed = {
        k: -1 if v == '?' else attribute_name_values[k].index(v)
        for k, v in features.items()
    }
    
    for k, v in features_indexed.items():
        # try:
        if ' ' in k:
            k = k.replace(' ', '-')
        
        fact_string = f"(feature (name {k}) (value {v}))"
        env.assert_string(fact_string)
        # except Exception as e:
        #     print(f"Error asserting fact: {fact_string}")
        #     print(e)
        #     result = {
        #         "disease": "No Result",
        #     }
        #     raise Exception(result)

    env.run()
    log_messages = []
    results = []
    result_dict = dict()
    for fact in env.facts():
        if fact.template.name == 'log-message':
            log_messages.append(str(fact['text']))
        if fact.template.name == 'diagnosis':
            res = fact['name']
            results.append(res)
            if (result_dict.get(res)):
                result_dict[res] += 1
            else:
                result_dict[res] = 1

    most_repeated_diagnosis = ""
    most_repeated_value = 0
    for k, v in result_dict.items():
        if v > most_repeated_value:
            most_repeated_value = v
            most_repeated_diagnosis = k

    most_repeated_diagnosis = most_repeated_diagnosis.replace("\"", "").replace('\n','')
    with open(f"rules_raw/{learned_rules_file}", "r") as f:
        rules = f.readlines()
        fired_rules = []
        for i in range(len(results)):
            # print(rules[i])
            if (results[i].startswith(most_repeated_diagnosis)):
                fired_rules.append(log_messages[i])

        features_used_in_rule = []
        for i in range(len(fired_rules)):
            rule_id = re.search("Rule-(\d+)", fired_rules[i]).group(1)
            fired_rule = (rules[int(rule_id) - 1])
            antecedents = fired_rule[3:].split("THEN")[0].strip().split("AND")

            for i in range(len(antecedents)):
                antecedents[i] = antecedents[i].strip()
                feature_name = re.search('(\w+\s\w+|\w+-\w+|\w+)', antecedents[i]).group(0)
                relational_op = re.search('<=|>=|<|>|!=|=|=:=', antecedents[i]).group(0)
                # value = re.search(r'\d+\.\d+', antecedents[i]).group(0)

                features_used_in_rule.append({
                    "feature": feature_name,
                    "relational_op": relational_op,
                    "value": features[feature_name],
                })
                # print(features_used_in_rule)

        print(features_used_in_rule)
        return {
            "disease": most_repeated_diagnosis,
            "interpretation": features_used_in_rule,
        }


def backward(features, attribute_name_values, algorithm="decision_tree"):
    if algorithm == "decision_tree":
        learned_rules_file = "learned_dt_rules.txt"
        algorithm_prolog = "rules_dt_prolog.pl"
    elif algorithm == "covering":
        learned_rules_file = "learned_CN2_rules.txt"
        algorithm_prolog = "rules_CN2_prolog.pl"
    elif algorithm == "association":
        learned_rules_file = "learned_rules_apriori.txt"
        algorithm_prolog = "rules_Apriori_prolog.pl"
    
    features['fruit spots'] = features['fruit-spots']
    del features['fruit-spots']

    features['external decay'] = features['external-decay']
    del features['external-decay']
    
    features_indexed = {
        k: -1 if v == '?' else attribute_name_values[k].index(v)
        for k, v in features.items()
    }
    prolog = Prolog()
    prolog.consult(f"declarative_rules/{algorithm_prolog}")
    
    features_list = []
    for k, v in features_indexed.items():
        if (v == -1): continue
        features_list.append(f'feature(\'{k}\', {v})')
    features_str = ', '.join(features_list)
    # print(f"Features: {features_str}")
    prolog_response = prolog.query(f"classify([{features_str}], Category, RuleID).")

    res = ""
    for soln in prolog_response:
        res = soln['Category']
        res = res.replace("\"", "").replace('\n','')
        rule_id = soln['RuleID']
        print(f"Rule {rule_id} fired → Prediction: {res}")
    
    with open(f"rules_raw/{learned_rules_file}", "r") as f:
        rules = f.readlines()
        fired_rule = (rules[rule_id - 1])
        antecedents = fired_rule[3:].split("THEN")[0].strip().split("AND")
        # print(f"Antecedent: {antecedents}")
        features_used_in_rule = []
        for i in range(len(antecedents)):
            antecedents[i] = antecedents[i].strip()
            feature_name = re.search('(\w+\s\w+|\w+-\w+|\w+)', antecedents[i]).group(0)
            relational_op = re.search('<=|>=|<|>|!=|=|=:=', antecedents[i]).group(0)
            value = re.search(r'\d+\.\d+', antecedents[i]).group(0)
            # print(f"Feature: {feature_name}, Relational Operator: {relational_op}, Value: {value}")
            if (features[feature_name] == "?"):
                print(f"Feature: {feature_name}, Relational Operator: {relational_op}, Value: {value}")
                result = {
                    "disease": "No Result",
                }
                return jsonify(result), 200
            
            features_used_in_rule.append({
                "feature": feature_name,
                "relational_op": relational_op,
                "value": features[feature_name],
            })

    result = {
        "disease": res,
        "interpretation": features_used_in_rule,
    }
    return result

if __name__ == "__main__":
    """ Main Function """
    host = '0.0.0.0'
    port = '5000'
    app.run(host=host, port=port, threaded=True, debug=True)
