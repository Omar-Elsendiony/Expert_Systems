rule(1, ['leafspots-marg' =< 0.50, 'leafspot-size' =< 0.50, 'canker-lesion' =< 1.50, 'roots' =< 0.50], '"bacterial-blight"
').
rule(2, ['leafspots-marg' =< 0.50, 'leafspot-size' =< 0.50, 'canker-lesion' =< 1.50, 'roots' >  0.50], '"bacterial-pustule"
').
rule(3, ['leafspots-marg' =< 0.50, 'leafspot-size' =< 0.50, 'canker-lesion' >  1.50], '"purple-seed-stain"
').
rule(4, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' =< 3.50, 'precip' =< 1.50, 'temp' =< 0.50], '"brown-stem-rot"
').
rule(5, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' =< 3.50, 'precip' =< 1.50, 'temp' >  0.50], '"phyllosticta-leaf-spot"
').
rule(6, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' =< 3.50, 'precip' >  1.50, 'seed' =< 0.50], '"brown-spot"
').
rule(7, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' =< 3.50, 'precip' >  1.50, 'seed' >  0.50], '"downy-mildew"
').
rule(8, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' >  3.50, 'stem' =< 0.50, 'leaf-mild' =< 1.00], '"alternarialeaf-spot"
').
rule(9, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' >  3.50, 'stem' =< 0.50, 'leaf-mild' >  1.00], '"downy-mildew"
').
rule(10, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' >  3.50, 'stem' >  0.50, 'fruit-pods' =< 0.50], '"brown-spot"
').
rule(11, ['leafspots-marg' =< 0.50, 'leafspot-size' >  0.50, 'date' >  3.50, 'stem' >  0.50, 'fruit-pods' >  0.50], '"frog-eye-leaf-spot"
').
rule(12, ['leafspots-marg' >  0.50, 'stem-cankers' =< 0.50, 'int-discolor' =< 0.50, 'leaf-mild' =< 0.50, 'leafspot-size' =< 1.00], '"bacterial-pustule"
').
rule(13, ['leafspots-marg' >  0.50, 'stem-cankers' =< 0.50, 'int-discolor' =< 0.50, 'leaf-mild' =< 0.50, 'leafspot-size' >  1.00], '"purple-seed-stain"
').
rule(14, ['leafspots-marg' >  0.50, 'stem-cankers' =< 0.50, 'int-discolor' =< 0.50, 'leaf-mild' >  0.50], '"powdery-mildew"
').
rule(15, ['leafspots-marg' >  0.50, 'stem-cankers' =< 0.50, 'int-discolor' >  0.50, 'sclerotia' =< 0.50], '"brown-stem-rot"
').
rule(16, ['leafspots-marg' >  0.50, 'stem-cankers' =< 0.50, 'int-discolor' >  0.50, 'sclerotia' >  0.50], '"charcoal-rot"
').
rule(17, ['leafspots-marg' >  0.50, 'stem-cankers' >  0.50, 'fruit-pods' =< 2.00, 'fruit spots' =< 3.00], '"anthracnose"
').
rule(18, ['leafspots-marg' >  0.50, 'stem-cankers' >  0.50, 'fruit-pods' =< 2.00, 'fruit spots' >  3.00], '"diaporthe-stem-canker"
').
rule(19, ['leafspots-marg' >  0.50, 'stem-cankers' >  0.50, 'fruit-pods' >  2.00, 'leaves' =< 0.50], '"rhizoctonia-root-rot"
').
rule(20, ['leafspots-marg' >  0.50, 'stem-cankers' >  0.50, 'fruit-pods' >  2.00, 'leaves' >  0.50], '"phytophthora-rot"').
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
% The cut (!) ensures we stop at the first matching rule
classify(Facts, Category, RuleID) :-
    rule(RuleID, Conditions, Category),
    satisfies(Facts, Conditions),
    !.
