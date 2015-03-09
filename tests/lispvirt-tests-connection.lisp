(defpackage :lispvirt-tests-connection
  (:use :cl :lispvirt :lispvirt-host :cffi :xlunit)
  (:export :run-all-tests-connection))

(in-package :lispvirt-tests-connection)

(defclass lispvirt-tests-connection (test-case)
  ())

(def-test-method test-virconnect ((test lispvirt-tests-connection) :run nil)
  (virConnectOpen "test:///default"))

(defun run-all-tests-connection ()
  (textui-test-run (get-suite lispvirt-tests-connection)))

;;(test test-virconnect
;;  (virconnectopen "test:///default"))
