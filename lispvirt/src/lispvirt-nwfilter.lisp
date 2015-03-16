;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-nwfilter.lisp is part of Lispvirt.
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

(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-nwfilter
  (:use :cl :cffi :lispvirt-host)
  (:export :virNWFilterPtr
	   :virConnectListNWFilters
	   :virConnectListAllNWFilters
	   :virNWFilterLookupByName
	   :virNWFilterLookupByUUID
	   :virNWFilterLookupByUUIDString
	   :virNWFilterDefineXML
	   :virNWFilterUndefine
	   :virNWFilterRef
	   :virNWFilterFree
	   :virNWFilterGetName
	   :virNWFilterGetUUID
	   :virNWFilterGetUUIDString
	   :virNWFilterGetXMLDesc))

(in-package :lispvirt-nwfilter)


;; Definitions of strucutres for Storage.
(defcstruct virNWFilter)


;; Pointers mapping to structures.
(defctype virNWFilterPtr (:pointer virNWFilter))


;; Methods.
(defcfun ("virConnectListNWFilters" %virConnectListNWFilters) :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

(defun virConnectListNWFilters (conn maxnames)
        (with-foreign-objects ((names :string))
                (%virConnectListNWFilters conn names maxnames)
                (values (mem-ref names :string))))

(defcfun ("virConnectListAllNWFilters" %virConnectListAllNWFilters) :int
	(conn virConnectPtr)
	(filters (:pointer (:pointer virNWFilterPtr)))
	(flags :uint))


;; Lookup nwfilter by name or uuid
(defcfun "virNWFilterLookupByName" virNWFilterPtr
	(conn virConnectPtr)
	(name :string))

(defcfun "virNWFilterLookupByUUID" virNWFilterPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virNWFilterLookupByUUIDString" virNWFilterPtr
	(conn virConnectPtr)
	(uuid :string))

;; Define persistent nwfilter
(defcfun "virNWFilterDefineXML" virNWFilterPtr
	(conn virConnectPtr)
	(xmlDesc :string))


;; Delete persistent nwfilter
(defcfun "virNWFilterUndefine" :int
	(nwfilter virNWFilterPtr))


;; NWFilter destroy/free
(defcfun "virNWFilterRef" :int
	(nwfilter virNWFilterPtr))

(defcfun "virNWFilterFree" :int
	(nwfilter virNWFilterPtr))


;; NWFilter information

(defcfun "virNWFilterGetName" :string
	(nwfilter virNWFilterPtr))

(defcfun "virNWFilterGetUUID" :int
	(nwfilter virNWFilterPtr)
	(uuid :string))

(defcfun "virNWFilterGetUUIDString" :int
	(nwfilter virNWFilterPtr)
	(buf :string))

(defcfun "virNWFilterGetXMLDesc" :string
	(nwfilter virNWFilterPtr)
	(flags :uint))
