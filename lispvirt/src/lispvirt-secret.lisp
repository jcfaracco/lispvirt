;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-secret.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-secret
  (:use :cl :cffi :lispvirt-ffi :lispvirt-host)
  (:export :virSecretPtr
	   :virSecretUsageType
	   :virConnectListAllSecretsFlags
	   :virSecretGetConnect
	   :virConnectNumOfSecrets
	   :virConnectListSecrets
	   :virConnectListAllSecrets
	   :virSecretLookupByUUID
	   :virSecretLookupByUUIDString
	   :virSecretLookupByUsage
	   :virSecretDefineXML
	   :virSecretGetUUID
	   :virSecretGetUUIDString
	   :virSecretGetUsageType
	   :virSecretGetUsageID
	   :virSecretGetXMLDesc
	   :virSecretSetValue
	   :virSecretGetValue
	   :virSecretUndefine
	   :virSecretRef
	   :virSecretFree))

(in-package :lispvirt-secret)


;; Definitions of strucutres for Storage.
(defcstruct virSecret)

(defcenum virSecretUsageType
	(:VIR_SECRET_USAGE_TYPE_NONE 0)
	(:VIR_SECRET_USAGE_TYPE_VOLUME 1)
	(:VIR_SECRET_USAGE_TYPE_CEPH 2)
	(:VIR_SECRET_USAGE_TYPE_ISCSI 3)
	(:VIR_SECRET_USAGE_TYPE_LAST))

(defcenum virConnectListAllSecretsFlags
	(:VIR_CONNECT_LIST_SECRETS_EPHEMERAL 1) ;; kept in memory, never stored persistently.
	(:VIR_CONNECT_LIST_SECRETS_NO_EPHEMERAL 2)
	(:VIR_CONNECT_LIST_SECRETS_PRIVATE 4) ;; not revealed to any caller of libvirt, nor to any other node.
	(:VIR_CONNECT_LIST_SECRETS_NO_PRIVATE 8))


;; Pointers mapping to structures.
(defctype virSecretPtr (:pointer virSecret))


;; Methods
(defcfun "virSecretGetConnect" virSecretPtr
	(secret virSecretPtr))

(defcfun "virConnectNumOfSecrets" :int
	(conn virConnectPtr conn))

(defcfun "virConnectListSecrets" :int
	(conn virConnectPtr)
	(uuids (:pointer :string))
	(maxuuids :int))

(defcfun ("virConnectListAllSecrets" %virConnectListAllSecrets) :int
	(conn virConnectPtr)
	(secrets (:pointer (:pointer virSecretPtr)))
	(flags :uint))

(defcfun "virSecretLookupByUUID" virSecretPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virSecretLookupByUUIDString" virSecretPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virSecretLookupByUsage" virSecretPtr
	(conn virConnectPtr)
	(usageType :int)
	(usageID :string))

(defcfun "virSecretDefineXML" virSecretPtr
	(conn virConnectPtr)
	(xml :string)
	(flags :uint))


(defcfun ("virSecretGetUUID" %virSecretGetUUID) :int
	(secret virSecretPtr)
	(buf :string))

(defcfun ("virSecretGetUUIDString" %virSecretGetUUIDString) :int
	(secret virSecretPtr)
	(buf :string))

(defcfun "virSecretGetUsageType" :int
	(secret virSecretPtr))

(defcfun "virSecretGetUsageID" :string
	(secret virSecretPtr))

(defcfun "virSecretGetXMLDesc" :string
	(secret virSecretPtr)
	(flags :uint))

(defcfun "virSecretSetValue" :int
	(secret virSecretPtr)
	(value :string)
	(value_size size_t)
	(flags :uint))

(defcfun ("virSecretGetValue" %virSecretGetValue) :string
	(secret virSecretPtr)
	(value_size (:pointer size_t))
	(flags :uint))

(defun virSecretGetValue (secret flags)
        (with-foreign-objects ((value_size size_t))
		(%virSecretGetValue secret value_size flags)
                (values (mem-ref value_size size_t))))

(defcfun "virSecretUndefine" :int
	(secret virSecretPtr))

(defcfun "virSecretRef" :int
	(secret virSecretPtr))

(defcfun "virSecretFree" :int
	(secret virSecretPtr))
