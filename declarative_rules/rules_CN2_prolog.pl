rule(1, ['leaf-mild'>=2.0], 'downy-mildew').
rule(2, ['leaf-mild'>=1.0], 'powdery-mildew').
rule(3, ['int-discolor'>=2.0], 'charcoal-rot').
rule(4, ['int-discolor'>=1.0], 'brown-stem-rot').
rule(5, ['roots'>=2.0, 'date'>=3.0], 'cyst-nematode').
rule(6, ['canker-lesion'>=3.0, 'plant-stand'>=1.0], 'brown-spot').
rule(7, ['canker-lesion'>=3.0, 'date'>=5.0], 'purple-seed-stain').
rule(8, ['canker-lesion'>=3.0, 'hail'>=1.0], 'purple-seed-stain').
rule(9, ['canker-lesion'>=3.0, 'crop-hist'>=2.0], 'brown-spot').
rule(10, ['canker-lesion'>=3.0], 'purple-seed-stain').
rule(11, ['shriveling'>=1.0, 'plant-growth'>=1.0], 'anthracnose').
rule(12, ['shriveling'>=1.0, 'leafspots-marg'>=2.0], 'anthracnose').
rule(13, ['shriveling'>=1.0, 'precip'>=2.0], 'diaporthe-pod-&-stem-blight').
rule(14, ['roots'>=1.0, 'hail'>=0.0], 'bacterial-pustule').
rule(15, ['roots'>=1.0, 'precip'>=1.0], 'phytophthora-rot').
rule(16, ['roots'>=2.0], 'cyst-nematode').
rule(17, ['roots'>=1.0], 'herbicide-injury').
rule(18, ['fruit-pods'>=3.0, 'temp'>=1.0], 'phytophthora-rot').
rule(19, ['fruit-pods'>=3.0, 'hail'>=1.0], 'rhizoctonia-root-rot').
rule(20, ['fruit-pods'>=3.0, 'crop-hist'>=3.0], 'rhizoctonia-root-rot').
rule(21, ['fruit-pods'>=3.0, 'leaves'>=1.0], 'phytophthora-rot').
rule(22, ['fruit-pods'>=3.0], 'rhizoctonia-root-rot').
rule(23, ['fruit spots'>=4.0], 'diaporthe-stem-canker').
rule(24, ['leafspots-marg'>=2.0, 'date'>=0.0], 'anthracnose').
rule(25, ['leafspots-marg'>=2.0], '2-4-d-injury').
rule(26, ['leafspots-marg'>=1.0], 'bacterial-pustule').
rule(27, ['canker-lesion'>=2.0], 'frog-eye-leaf-spot').
rule(28, ['external decay'>=1.0], 'frog-eye-leaf-spot').
rule(29, ['canker-lesion'>=1.0], 'brown-spot').
rule(30, ['stem-cankers'>=3.0], 'frog-eye-leaf-spot').
rule(31, ['stem'>=1.0], 'diaporthe-pod-&-stem-blight').
rule(32, ['seed'>=1.0], 'alternarialeaf-spot').
rule(33, ['leaf-malf'>=1.0, 'plant-stand'>=1.0], 'phyllosticta-leaf-spot').
rule(34, ['leaf-malf'>=1.0, 'precip'>=1.0], 'bacterial-blight').
rule(35, ['leaf-malf'>=1.0], 'phyllosticta-leaf-spot').
rule(36, ['seed-tmt'>=2.0, 'precip'>=2.0], 'brown-spot').
rule(37, ['date'>=4.0, 'hail'>=1.0], 'bacterial-blight').
rule(38, ['date'>=4.0, 'seed-tmt'>=2.0], 'frog-eye-leaf-spot').
rule(39, ['plant-growth'>=1.0, 'plant-stand'>=1.0], 'brown-spot').
rule(40, ['seed-tmt'>=2.0], 'phyllosticta-leaf-spot').
rule(41, ['plant-growth'>=1.0], 'phyllosticta-leaf-spot').
rule(42, ['temp'>=2.0, 'date'>=5.0], 'alternarialeaf-spot').
rule(43, ['date'>=4.0, 'leaf-shread'>=1.0], 'alternarialeaf-spot').
rule(44, ['leaf-shread'>=1.0, 'plant-stand'>=1.0], 'brown-spot').
rule(45, ['temp'>=2.0, 'crop-hist'>=3.0], 'alternarialeaf-spot').
rule(46, ['leaf-shread'>=1.0, 'hail'>=1.0], 'bacterial-blight').
rule(47, ['leaf-shread'>=1.0, 'precip'>=2.0], 'brown-spot').
rule(48, ['leaf-shread'>=1.0], 'bacterial-blight').
rule(49, ['hail'>=1.0, 'plant-stand'>=1.0], 'brown-spot').
rule(50, ['hail'>=1.0], 'phyllosticta-leaf-spot').
rule(51, ['temp'>=2.0, 'severity'>=1.0], 'alternarialeaf-spot').
rule(52, ['temp'>=2.0], 'frog-eye-leaf-spot').
rule(53, ['seed-tmt'>=1.0, 'plant-stand'>=1.0, 'area-damaged'>=3.0], 'frog-eye-leaf-spot').
rule(54, ['seed-tmt'>=1.0, 'plant-stand'>=1.0], 'alternarialeaf-spot').
rule(55, ['crop-hist'=<1.0, 'crop-hist'>=1.0], 'frog-eye-leaf-spot').
rule(56, ['germination'=<1.0, 'plant-stand'>=1.0], 'phyllosticta-leaf-spot').
rule(57, ['date'>=3.0, 'seed-tmt'>=1.0, 'precip'>=2.0], 'frog-eye-leaf-spot').
rule(58, ['precip'>=2.0, 'seed-tmt'>=1.0], 'brown-spot').
rule(59, ['seed-tmt'>=1.0, 'severity'>=1.0], 'frog-eye-leaf-spot').
rule(60, ['seed-tmt'>=1.0], 'alternarialeaf-spot').
rule(61, ['area-damaged'>=3.0, 'date'>=4.0], 'alternarialeaf-spot').
rule(62, ['area-damaged'>=3.0], 'brown-spot').
rule(63, ['severity'>=1.0, 'crop-hist'>=3.0], 'frog-eye-leaf-spot').
rule(64, ['severity'>=1.0], 'alternarialeaf-spot').
rule(65, ['date'>=4.0, 'crop-hist'>=3.0], 'frog-eye-leaf-spot').
rule(66, ['date'>=4.0, 'plant-stand'>=1.0], 'alternarialeaf-spot').
rule(67, ['plant-stand'>=1.0], 'phyllosticta-leaf-spot').
rule(68, ['area-damaged'>=1.0], 'alternarialeaf-spot').
rule(69, ['date'>=4.0], 'frog-eye-leaf-spot').
rule(70, ['date'=<2.0], 'bacterial-blight').

% Step 2: Define a way to check if a fact satisfies conditions

% Base case: empty condition list is always satisfied
satisfies(_, []).  

% Recursive case: check each condition in the list
satisfies(Facts, [Condition|Rest]) :-
    check_condition(Facts, Condition),
    satisfies(Facts, Rest).

% Step 3: Define how to check individual conditions
% These will need to be customized based on your actual feature names
check_condition(Facts, Feature > Value) :-
    atom(Feature),  % Make sure Feature is an atom (symbol)
    member(feature(Feature, X), Facts),
    number(X),      % Make sure X is a number
    X > Value.

check_condition(Facts, Feature < Value) :-
    atom(Feature),
    member(feature(Feature, X), Facts),
    number(X),
    X < Value.

check_condition(Facts, Feature = Value) :-
    atom(Feature),
    member(feature(Feature, X), Facts),
    X = Value.

check_condition(Facts, Feature >= Value) :-
    atom(Feature),
    member(feature(Feature, X), Facts),
    number(X),
    X >= Value.

check_condition(Facts, Feature =< Value) :-
    atom(Feature),
    member(feature(Feature, X), Facts),
    number(X),
    X =< Value.

check_condition(Facts, Feature \= Value) :-
    atom(Feature),
    member(feature(Feature, X), Facts),
    X \= Value.

% Step 4: Define the classification predicate
% Original: classify(Facts, Category) :- ...
% Modified to also return the rule number
classify(Facts, Category, RuleID) :-
    rule(RuleID, Conditions, Category),
    satisfies(Facts, Conditions),
    !.

