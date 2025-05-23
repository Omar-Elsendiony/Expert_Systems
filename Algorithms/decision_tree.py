from flask import render_template, jsonify
from pyswip import Prolog
import re


def decision_tree_forward(features, attribute_name_values):
    """ Decision Tree """
    from clips import Environment  # Import here to ensure fresh instance per test case
    env = Environment()
    env.clear()  # fully resets the environment
    env.load('declarative_rules/rules_dt_CLIPS.clp')
    env.reset()
    res = None
    features_indexed = {
        k: -1 if v == '?' else attribute_name_values[k].index(v)
        for k, v in features.items()
    }
    
    for k, v in features_indexed.items():
        fact_string = f"(feature (name {k}) (value {v}))"
        env.assert_string(fact_string)

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
    with open("../rules_raw/learned_dt_rules.txt", "r") as f:
        rules = f.readlines()
        fired_rules = []
        for i in range(len(rules)):
            rules[i] = rules[i].replace("\"", "").replace('\n','')
            if (rules[i].startswith(most_repeated_diagnosis)):
                fired_rules.append(log_messages[i])

        features_used_in_rule = []
        with open("../rules_raw/learned_dt_rules.txt", "r") as f:
            rules = f.readlines()
            for i in range(len(fired_rules)):
                rule_id = re.search("Rule-(\d+)", fired_rules[i]).group(1)
                fired_rule = (rules[int(rule_id) - 1])
                antecedents = fired_rule[3:].split("THEN")[0].strip().split("AND")

                for i in range(len(antecedents)):
                    antecedents[i] = antecedents[i].strip()
                    feature_name = re.search('(\w+\s\w+|\w+-\w+|\w+)', antecedents[i]).group(0)
                    relational_op = re.search('<=|>=|<|>|!=|=|=:=', antecedents[i]).group(0)
                    value = re.search(r'\d+\.\d+', antecedents[i]).group(0)
                    # print(f"Feature: {feature_name}, Relational Operator: {relational_op}, Value: {value}")
                    # if (features[feature_name] == "?"):
                    #     print(f"Feature: {feature_name}, Relational Operator: {relational_op}, Value: {value}")
                    #     result = {
                    #         "disease": "No Result",
                    #     }
                    #     return jsonify(result), 200

                    features_used_in_rule.append({
                        "feature": feature_name,
                        "relational_op": relational_op,
                        "value": features[feature_name],
                    })
        return {
            "disease": most_repeated_diagnosis,
            "interpretation": features_used_in_rule,
        }


def decision_tree_backward(features, attribute_name_values):
    features['fruit spots'] = features['fruit-spots']
    del features['fruit-spots']

    features['external decay'] = features['external-decay']
    del features['external-decay']
    
    features_indexed = {
        k: -1 if v == '?' else attribute_name_values[k].index(v)
        for k, v in features.items()
    }
    prolog = Prolog()
    prolog.consult("declarative_rules/rules_dt_prolog.pl")
    
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
    
    with open("../rules_raw/learned_dt_rules.txt", "r") as f:
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
