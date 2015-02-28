(defpackage :lispvirt-tests
  (:use :cl :lispvirt :cffi)
  (:export :run-all-virtests))

(in-package :lispvirt-tests)

(def-suite lispvirt-suite)

(defun run-all-virtests ()
  (run! 'lispvirt-suite))

(in-suite lispvirt-suite)
