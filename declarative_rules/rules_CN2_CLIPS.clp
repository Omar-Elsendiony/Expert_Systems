
;; Modified CLIPS code with fixed diagnosis counting mechanism
(deftemplate feature
  (slot name)
  (slot value))

(deftemplate diagnosis
  (slot name)
  (slot id (type INTEGER) (default 0)))  ; Add unique ID to distinguish multiple diagnoses of same type

(deftemplate log-message
  (slot text))

(deftemplate diagnosis-counter
  (slot name)
  (slot count (type INTEGER) (default 1)))

;; Add a template for tracking which diagnoses have been counted
(deftemplate counted-diagnosis
  (slot id (type INTEGER)))

(defglobal ?*diagnosis-id* = 0)

;; Modified aggregation rule to count diagnoses - now prevents infinite loop by checking IDs
(defrule count-diagnoses
  ?d <- (diagnosis (name ?name) (id ?id))
  ?dc <- (diagnosis-counter (name ?name) (count ?count))
  (not (counted-diagnosis (id ?id)))  ; Make sure this diagnosis hasn't been counted yet
  =>
  (retract ?dc)
  (assert (diagnosis-counter (name ?name) (count (+ ?count 1))))
  (assert (counted-diagnosis (id ?id)))  ; Mark this diagnosis as counted
)

;; Add a rule to create counter if one doesn't exist
(defrule create-diagnosis-counter
  (diagnosis (name ?name) (id ?id))
  (not (diagnosis-counter (name ?name)))
  (not (counted-diagnosis (id ?id)))
  =>
  (assert (diagnosis-counter (name ?name) (count 1)))
  (assert (counted-diagnosis (id ?id)))  ; Mark this diagnosis as counted
)

;; Helper function to create a unique ID for each diagnosis
(deffunction next-id ()
  (bind ?*diagnosis-id* (+ ?*diagnosis-id* 1))
  (return ?*diagnosis-id*)
)


(defrule rule-1
  (feature (name leaf-mild) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-1 Fired")))
  (assert (diagnosis (name "downy-mildew") (id (next-id)))))

    

(defrule rule-2
  (feature (name leaf-mild) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-2 Fired")))
  (assert (diagnosis (name "powdery-mildew") (id (next-id)))))

    

(defrule rule-3
  (feature (name int-discolor) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-3 Fired")))
  (assert (diagnosis (name "charcoal-rot") (id (next-id)))))

    

(defrule rule-4
  (feature (name int-discolor) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-4 Fired")))
  (assert (diagnosis (name "brown-stem-rot") (id (next-id)))))

    

(defrule rule-5
  (feature (name roots) (value ?v1&:(>= ?v1 2.0)))
  (feature (name date) (value ?v2&:(>= ?v2 3.0)))
  =>
  (assert (log-message (text "Rule-5 Fired")))
  (assert (diagnosis (name "cyst-nematode") (id (next-id)))))

    

(defrule rule-6
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 3.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-6 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-7
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 3.0)))
  (feature (name date) (value ?v2&:(>= ?v2 5.0)))
  =>
  (assert (log-message (text "Rule-7 Fired")))
  (assert (diagnosis (name "purple-seed-stain") (id (next-id)))))

    

(defrule rule-8
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 3.0)))
  (feature (name hail) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-8 Fired")))
  (assert (diagnosis (name "purple-seed-stain") (id (next-id)))))

    

(defrule rule-9
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 3.0)))
  (feature (name crop-hist) (value ?v2&:(>= ?v2 2.0)))
  =>
  (assert (log-message (text "Rule-9 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-10
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 3.0)))
  =>
  (assert (log-message (text "Rule-10 Fired")))
  (assert (diagnosis (name "purple-seed-stain") (id (next-id)))))

    

(defrule rule-11
  (feature (name shriveling) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-growth) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-11 Fired")))
  (assert (diagnosis (name "anthracnose") (id (next-id)))))

    

(defrule rule-12
  (feature (name shriveling) (value ?v1&:(>= ?v1 1.0)))
  (feature (name leafspots-marg) (value ?v2&:(>= ?v2 2.0)))
  =>
  (assert (log-message (text "Rule-12 Fired")))
  (assert (diagnosis (name "anthracnose") (id (next-id)))))

    

(defrule rule-13
  (feature (name shriveling) (value ?v1&:(>= ?v1 1.0)))
  (feature (name precip) (value ?v2&:(>= ?v2 2.0)))
  =>
  (assert (log-message (text "Rule-13 Fired")))
  (assert (diagnosis (name "diaporthe-pod-&-stem-blight") (id (next-id)))))

    

(defrule rule-14
  (feature (name roots) (value ?v1&:(>= ?v1 1.0)))
  (feature (name hail) (value ?v2&:(>= ?v2 0.0)))
  =>
  (assert (log-message (text "Rule-14 Fired")))
  (assert (diagnosis (name "bacterial-pustule") (id (next-id)))))

    

(defrule rule-15
  (feature (name roots) (value ?v1&:(>= ?v1 1.0)))
  (feature (name precip) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-15 Fired")))
  (assert (diagnosis (name "phytophthora-rot") (id (next-id)))))

    

(defrule rule-16
  (feature (name roots) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-16 Fired")))
  (assert (diagnosis (name "cyst-nematode") (id (next-id)))))

    

(defrule rule-17
  (feature (name roots) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-17 Fired")))
  (assert (diagnosis (name "herbicide-injury") (id (next-id)))))

    

(defrule rule-18
  (feature (name fruit-pods) (value ?v1&:(>= ?v1 3.0)))
  (feature (name temp) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-18 Fired")))
  (assert (diagnosis (name "phytophthora-rot") (id (next-id)))))

    

(defrule rule-19
  (feature (name fruit-pods) (value ?v1&:(>= ?v1 3.0)))
  (feature (name hail) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-19 Fired")))
  (assert (diagnosis (name "rhizoctonia-root-rot") (id (next-id)))))

    

(defrule rule-20
  (feature (name fruit-pods) (value ?v1&:(>= ?v1 3.0)))
  (feature (name crop-hist) (value ?v2&:(>= ?v2 3.0)))
  =>
  (assert (log-message (text "Rule-20 Fired")))
  (assert (diagnosis (name "rhizoctonia-root-rot") (id (next-id)))))

    

(defrule rule-21
  (feature (name fruit-pods) (value ?v1&:(>= ?v1 3.0)))
  (feature (name leaves) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-21 Fired")))
  (assert (diagnosis (name "phytophthora-rot") (id (next-id)))))

    

(defrule rule-22
  (feature (name fruit-pods) (value ?v1&:(>= ?v1 3.0)))
  =>
  (assert (log-message (text "Rule-22 Fired")))
  (assert (diagnosis (name "rhizoctonia-root-rot") (id (next-id)))))

    

(defrule rule-23
  (feature (name fruit-spots) (value ?v1&:(>= ?v1 4.0)))
  =>
  (assert (log-message (text "Rule-23 Fired")))
  (assert (diagnosis (name "diaporthe-stem-canker") (id (next-id)))))

    

(defrule rule-24
  (feature (name leafspots-marg) (value ?v1&:(>= ?v1 2.0)))
  (feature (name date) (value ?v2&:(>= ?v2 0.0)))
  =>
  (assert (log-message (text "Rule-24 Fired")))
  (assert (diagnosis (name "anthracnose") (id (next-id)))))

    

(defrule rule-25
  (feature (name leafspots-marg) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-25 Fired")))
  (assert (diagnosis (name "2-4-d-injury") (id (next-id)))))

    

(defrule rule-26
  (feature (name leafspots-marg) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-26 Fired")))
  (assert (diagnosis (name "bacterial-pustule") (id (next-id)))))

    

(defrule rule-27
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-27 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-28
  (feature (name external-decay) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-28 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-29
  (feature (name canker-lesion) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-29 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-30
  (feature (name stem-cankers) (value ?v1&:(>= ?v1 3.0)))
  =>
  (assert (log-message (text "Rule-30 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-31
  (feature (name stem) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-31 Fired")))
  (assert (diagnosis (name "diaporthe-pod-&-stem-blight") (id (next-id)))))

    

(defrule rule-32
  (feature (name seed) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-32 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-33
  (feature (name leaf-malf) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-33 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-34
  (feature (name leaf-malf) (value ?v1&:(>= ?v1 1.0)))
  (feature (name precip) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-34 Fired")))
  (assert (diagnosis (name "bacterial-blight") (id (next-id)))))

    

(defrule rule-35
  (feature (name leaf-malf) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-35 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-36
  (feature (name seed-tmt) (value ?v1&:(>= ?v1 2.0)))
  (feature (name precip) (value ?v2&:(>= ?v2 2.0)))
  =>
  (assert (log-message (text "Rule-36 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-37
  (feature (name date) (value ?v1&:(>= ?v1 4.0)))
  (feature (name hail) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-37 Fired")))
  (assert (diagnosis (name "bacterial-blight") (id (next-id)))))

    

(defrule rule-38
  (feature (name date) (value ?v1&:(>= ?v1 4.0)))
  (feature (name seed-tmt) (value ?v2&:(>= ?v2 2.0)))
  =>
  (assert (log-message (text "Rule-38 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-39
  (feature (name plant-growth) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-39 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-40
  (feature (name seed-tmt) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-40 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-41
  (feature (name plant-growth) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-41 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-42
  (feature (name temp) (value ?v1&:(>= ?v1 2.0)))
  (feature (name date) (value ?v2&:(>= ?v2 5.0)))
  =>
  (assert (log-message (text "Rule-42 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-43
  (feature (name date) (value ?v1&:(>= ?v1 4.0)))
  (feature (name leaf-shread) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-43 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-44
  (feature (name leaf-shread) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-44 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-45
  (feature (name temp) (value ?v1&:(>= ?v1 2.0)))
  (feature (name crop-hist) (value ?v2&:(>= ?v2 3.0)))
  =>
  (assert (log-message (text "Rule-45 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-46
  (feature (name leaf-shread) (value ?v1&:(>= ?v1 1.0)))
  (feature (name hail) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-46 Fired")))
  (assert (diagnosis (name "bacterial-blight") (id (next-id)))))

    

(defrule rule-47
  (feature (name leaf-shread) (value ?v1&:(>= ?v1 1.0)))
  (feature (name precip) (value ?v2&:(>= ?v2 2.0)))
  =>
  (assert (log-message (text "Rule-47 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-48
  (feature (name leaf-shread) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-48 Fired")))
  (assert (diagnosis (name "bacterial-blight") (id (next-id)))))

    

(defrule rule-49
  (feature (name hail) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-49 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-50
  (feature (name hail) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-50 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-51
  (feature (name temp) (value ?v1&:(>= ?v1 2.0)))
  (feature (name severity) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-51 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-52
  (feature (name temp) (value ?v1&:(>= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-52 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-53
  (feature (name seed-tmt) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  (feature (name area-damaged) (value ?v3&:(>= ?v3 3.0)))
  =>
  (assert (log-message (text "Rule-53 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-54
  (feature (name seed-tmt) (value ?v1&:(>= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-54 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-55
  (feature (name crop-hist) (value ?v1&:(<= ?v1 1.0)))
  (feature (name crop-hist) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-55 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-56
  (feature (name germination) (value ?v1&:(<= ?v1 1.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-56 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-57
  (feature (name date) (value ?v1&:(>= ?v1 3.0)))
  (feature (name seed-tmt) (value ?v2&:(>= ?v2 1.0)))
  (feature (name precip) (value ?v3&:(>= ?v3 2.0)))
  =>
  (assert (log-message (text "Rule-57 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-58
  (feature (name precip) (value ?v1&:(>= ?v1 2.0)))
  (feature (name seed-tmt) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-58 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-59
  (feature (name seed-tmt) (value ?v1&:(>= ?v1 1.0)))
  (feature (name severity) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-59 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-60
  (feature (name seed-tmt) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-60 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-61
  (feature (name area-damaged) (value ?v1&:(>= ?v1 3.0)))
  (feature (name date) (value ?v2&:(>= ?v2 4.0)))
  =>
  (assert (log-message (text "Rule-61 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-62
  (feature (name area-damaged) (value ?v1&:(>= ?v1 3.0)))
  =>
  (assert (log-message (text "Rule-62 Fired")))
  (assert (diagnosis (name "brown-spot") (id (next-id)))))

    

(defrule rule-63
  (feature (name severity) (value ?v1&:(>= ?v1 1.0)))
  (feature (name crop-hist) (value ?v2&:(>= ?v2 3.0)))
  =>
  (assert (log-message (text "Rule-63 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-64
  (feature (name severity) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-64 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-65
  (feature (name date) (value ?v1&:(>= ?v1 4.0)))
  (feature (name crop-hist) (value ?v2&:(>= ?v2 3.0)))
  =>
  (assert (log-message (text "Rule-65 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-66
  (feature (name date) (value ?v1&:(>= ?v1 4.0)))
  (feature (name plant-stand) (value ?v2&:(>= ?v2 1.0)))
  =>
  (assert (log-message (text "Rule-66 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-67
  (feature (name plant-stand) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-67 Fired")))
  (assert (diagnosis (name "phyllosticta-leaf-spot") (id (next-id)))))

    

(defrule rule-68
  (feature (name area-damaged) (value ?v1&:(>= ?v1 1.0)))
  =>
  (assert (log-message (text "Rule-68 Fired")))
  (assert (diagnosis (name "alternarialeaf-spot") (id (next-id)))))

    

(defrule rule-69
  (feature (name date) (value ?v1&:(>= ?v1 4.0)))
  =>
  (assert (log-message (text "Rule-69 Fired")))
  (assert (diagnosis (name "frog-eye-leaf-spot") (id (next-id)))))

    

(defrule rule-70
  (feature (name date) (value ?v1&:(<= ?v1 2.0)))
  =>
  (assert (log-message (text "Rule-70 Fired")))
  (assert (diagnosis (name "bacterial-blight") (id (next-id)))))

    
