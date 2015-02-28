(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-nwfilter
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Definitions of strucutres for Storage.
(defcstruct virNWFilter)


;; Pointers mapping to structures.
(defctype virNWFilterPtr (:pointer virNWFilter))


;; Methods.
(defcfun ("virConnectListNWFilters" %virConnectListNWFilters) :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

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
