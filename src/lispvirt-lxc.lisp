(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-lxc
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Methods
(defcfun ("virDomainLxcOpenNamespace" %virDomainLxcOpenNamespace) :int
	(domain virDomainPtr)
	(fdlist (:pointer (:pointer :int)))
	(flags :uint))

(defcfun ("virDomainLxcEnterNamespace" %virDomainLxcEnterNamespace) :int
	(domain virDomainPtr)
	(nfdlist :uint)
	(fdlist (:pointer :int))
	(noldfdlist (:pointer :uint))
	(oldfdlist (:pointer (:pointer :int)))
	(flags :uint))

(defcfun "virDomainLxcEnterSecurityLabel" :int
	(model virSecurityModelPtr)
	(label virSecurityLabelPtr)
	(oldLabel virSecurityLabelPtr)
	(flags :uint))
