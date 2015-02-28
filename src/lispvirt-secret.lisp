(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-secret
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


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

(defcfun "virSecretUndefine" :int
	(secret virSecretPtr))

(defcfun "virSecretRef" :int
	(secret virSecretPtr))

(defcfun "virSecretFree" :int
	(secret virSecretPtr))
