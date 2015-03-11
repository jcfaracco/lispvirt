;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-tests-connection.lisp is part of Lispvirt.
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
