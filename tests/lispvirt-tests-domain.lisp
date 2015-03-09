(defpackage :lispvirt-tests-domain
  (:use :cl :lispvirt :lispvirt-host :lispvirt-domain :cffi :xlunit)
  (:export :run-all-tests-domain))

(in-package :lispvirt-tests-domain)

(defclass lispvirt-tests-domain (test-case)
  ())

(def-test-method test-virdomain ((test lispvirt-tests-domain) :run nil)
  (virDomainLookupByName
    (virConnectOpen "test:///default")
    "test"))

(defun run-all-tests-domain ()
  (textui-test-run (get-suite lispvirt-tests-domain)))

;;(test test-virconnect
;;  (virconnectopen "test:///default"))
