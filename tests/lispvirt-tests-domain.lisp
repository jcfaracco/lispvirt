;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-tests-domain.lisp is part of Lispvirt.
;;;
;;; Lispvirt is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; Lispvirt is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Lispvirt.  If not, see <http://www.gnu.org/licenses/>.
;;;-------------------------------------------------------------------------

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
