; Forward-chaining CLIPS rules converted from Prolog-like format

(deftemplate feature
  (slot name)
  (slot value))

(deftemplate diagnosis
  (slot name))

(deftemplate log-message (slot text))

;; Rule 1
(defrule rule-1
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(<= ?ls 0.50)))
  (feature (name canker-lesion) (value ?cl&:(<= ?cl 1.50)))
  (feature (name roots) (value ?r&:(<= ?r 0.50)))
  =>
  (assert (log-message (text "Rule-1 Fired")))
  (assert (diagnosis (name bacterial-blight))))

;; Rule 2
(defrule rule-2
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(<= ?ls 0.50)))
  (feature (name canker-lesion) (value ?cl&:(<= ?cl 1.50)))
  (feature (name roots) (value ?r&:(> ?r 0.50)))
  =>
  ;(printout t "Rule-2" crlf)
  (assert (log-message (text "Rule-2 Fired")))
  (assert (diagnosis (name bacterial-pustule))))

;; Rule 3
(defrule rule-3
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(<= ?ls 0.50)))
  (feature (name canker-lesion) (value ?cl&:(> ?cl 1.50)))
  =>
  ;(printout t "Rule-3" crlf)
  (assert (log-message (text "Rule-3 Fired")))
  (assert (diagnosis (name purple-seed-stain))))

;; Rule 4
(defrule rule-4
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(<= ?d 3.50)))
  (feature (name precip) (value ?p&:(<= ?p 1.50)))
  (feature (name temp) (value ?t&:(<= ?t 0.50)))
  =>
  ;(printout t "Rule-4" crlf)
  (assert (log-message (text "Rule-4 Fired")))
  (assert (diagnosis (name brown-stem-rot))))

;; Rule 5
(defrule rule-5
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(<= ?d 3.50)))
  (feature (name precip) (value ?p&:(<= ?p 1.50)))
  (feature (name temp) (value ?t&:(> ?t 0.50)))
  =>
  (assert (log-message (text "Rule-5 Fired")))
  (assert (diagnosis (name phyllosticta-leaf-spot))))

;; Rule 6
(defrule rule-6
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(<= ?d 3.50)))
  (feature (name precip) (value ?p&:(> ?p 1.50)))
  (feature (name seed) (value ?s&:(<= ?s 0.50)))
  =>
  (assert (log-message (text "Rule-6 Fired")))
  (assert (diagnosis (name brown-spot))))

;; Rule 7
(defrule rule-7
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(<= ?d 3.50)))
  (feature (name precip) (value ?p&:(> ?p 1.50)))
  (feature (name seed) (value ?s&:(> ?s 0.50)))
  =>
  (assert (log-message (text "Rule-7 Fired")))
  (assert (diagnosis (name downy-mildew))))

;; Rule 8
(defrule rule-8
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(> ?d 3.50)))
  (feature (name stem) (value ?st&:(<= ?st 0.50)))
  (feature (name leaf-mild) (value ?lmf&:(<= ?lmf 1.00)))
  =>
  (assert (log-message (text "Rule-8 Fired")))
  (assert (diagnosis (name alternarialeaf-spot))))

;; Rule 9
(defrule rule-9
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(> ?d 3.50)))
  (feature (name stem) (value ?st&:(<= ?st 0.50)))
  (feature (name leaf-mild) (value ?lmf&:(> ?lmf 1.00)))
  =>
  (assert (log-message (text "Rule-9 Fired")))
  (assert (diagnosis (name downy-mildew))))

;; Rule 10
(defrule rule-10
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(> ?d 3.50)))
  (feature (name stem) (value ?st&:(> ?st 0.50)))
  (feature (name fruit-pods) (value ?fp&:(<= ?fp 0.50)))
  =>
  (assert (log-message (text "Rule-10 Fired")))
  (assert (diagnosis (name brown-spot))))

;; Rule 11
(defrule rule-11
  (feature (name leafspots-marg) (value ?lm&:(<= ?lm 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 0.50)))
  (feature (name date) (value ?d&:(> ?d 3.50)))
  (feature (name stem) (value ?st&:(> ?st 0.50)))
  (feature (name fruit-pods) (value ?fp&:(> ?fp 0.50)))
  =>
  (assert (log-message (text "Rule-11 Fired")))
  (assert (diagnosis (name frog-eye-leaf-spot))))

;; Rule 12
(defrule rule-12
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(<= ?sc 0.50)))
  (feature (name int-discolor) (value ?id&:(<= ?id 0.50)))
  (feature (name leaf-mild) (value ?lmf&:(<= ?lmf 0.50)))
  (feature (name leafspot-size) (value ?ls&:(<= ?ls 1.00)))
  =>
  (assert (log-message (text "Rule-12 Fired")))
  (assert (diagnosis (name bacterial-pustule))))

;; Rule 13
(defrule rule-13
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(<= ?sc 0.50)))
  (feature (name int-discolor) (value ?id&:(<= ?id 0.50)))
  (feature (name leaf-mild) (value ?lmf&:(<= ?lmf 0.50)))
  (feature (name leafspot-size) (value ?ls&:(> ?ls 1.00)))
  =>
  (assert (log-message (text "Rule-13 Fired")))
  (assert (diagnosis (name purple-seed-stain))))

;; Rule 14
(defrule rule-14
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(<= ?sc 0.50)))
  (feature (name int-discolor) (value ?id&:(<= ?id 0.50)))
  (feature (name leaf-mild) (value ?lmf&:(> ?lmf 0.50)))
  =>
  (assert (log-message (text "Rule-14 Fired")))
  (assert (diagnosis (name powdery-mildew))))

;; Rule 15
(defrule rule-15
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(<= ?sc 0.50)))
  (feature (name int-discolor) (value ?id&:(> ?id 0.50)))
  (feature (name sclerotia) (value ?s&:(<= ?s 0.50)))
  =>
  (assert (log-message (text "Rule-15 Fired")))
  (assert (diagnosis (name brown-stem-rot))))

;; Rule 16
(defrule rule-16
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(<= ?sc 0.50)))
  (feature (name int-discolor) (value ?id&:(> ?id 0.50)))
  (feature (name sclerotia) (value ?s&:(> ?s 0.50)))
  =>
  (assert (log-message (text "Rule-16 Fired")))
  (assert (diagnosis (name charcoal-rot))))

;; Rule 17
(defrule rule-17
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(> ?sc 0.50)))
  (feature (name fruit-pods) (value ?fp&:(<= ?fp 2.00)))
  (feature (name fruit-spots) (value ?fs&:(<= ?fs 3.00)))
  =>
  (assert (log-message (text "Rule-17 Fired")))
  (assert (diagnosis (name anthracnose))))

;; Rule 18
(defrule rule-18
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(> ?sc 0.50)))
  (feature (name fruit-pods) (value ?fp&:(<= ?fp 2.00)))
  (feature (name fruit-spots) (value ?fs&:(> ?fs 3.00)))
  =>
  (assert (log-message (text "Rule-18 Fired")))
  (assert (diagnosis (name diaporthe-stem-canker))))

;; Rule 19
(defrule rule-19
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(> ?sc 0.50)))
  (feature (name fruit-pods) (value ?fp&:(> ?fp 2.00)))
  (feature (name leaves) (value ?l&:(<= ?l 0.50)))
  =>
  (assert (log-message (text "Rule-19 Fired")))
  (assert (diagnosis (name rhizoctonia-root-rot))))

;; Rule 20
(defrule rule-20
  (feature (name leafspots-marg) (value ?lm&:(> ?lm 0.50)))
  (feature (name stem-cankers) (value ?sc&:(> ?sc 0.50)))
  (feature (name fruit-pods) (value ?fp&:(> ?fp 2.00)))
  (feature (name leaves) (value ?l&:(> ?l 0.50)))
  =>
  ;(printout t "Rule-20" crlf)
  (assert (log-message (text "Rule-20 Fired")))

  (assert (diagnosis (name phytophthora-rot))))
