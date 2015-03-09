(defpackage :lispvirt-tests
  (:use :cl :lispvirt :lispvirt-tests-connection :lispvirt-tests-domain :xlunit))

(in-package :lispvirt-tests)

(defun run-all-tests ()
  (progn
    (run-all-tests-connection)
    (run-all-tests-domain)))

;;(test test-virconnect
;;  (virconnectopen "test:///default"))
