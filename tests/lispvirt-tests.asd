;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-tests.asd is part of Lispvirt.
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

(defsystem :lispvirt-tests
	:name "lispvirt-tests"
	:author "Julio Faracco <jcfaracco@gmail.com>"
	:version "1.0.0"
	:license "Public Domain"
	:components ((:file "lispvirt-tests-connection")
		     (:file "lispvirt-tests-domain")
		     (:file "lispvirt-tests"
                      :depends-on ("lispvirt-tests-connection" "lispvirt-tests-domain")))
	:depends-on (lispvirt cffi xlunit))

