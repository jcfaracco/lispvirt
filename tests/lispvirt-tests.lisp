(defpackage :lispvirt-tests
  (:use :cl :lispvirt :lispvirt-host :cffi :xlunit))

(in-package :lispvirt-tests)

(defclass lispvirt-test-connection (test-case)
  ())

(def-test-method test-virconnect ((test lispvirt-test-connection))
  (virConnectOpen "test:///default"))

(defun run-all-test-connection ()
  (textui-test-run (get-suite lispvirt-test-connection)))

;;(test test-virconnect
;;  (virconnectopen "test:///default"))
