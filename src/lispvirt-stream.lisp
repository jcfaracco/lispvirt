(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-stream
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Methods.
(defcfun "virStreamNew" virStreamPtr
	(conn virConnectPtr)
	(flags :uint))

(defcfun "virStreamRef" :int
	(stream virStreamPtr))

(defcfun "virStreamSend" :int
	(stream virStreamPtr)
	(data :string)
	(nbytes size_t))

(defcfun "virStreamRecv" :int
	(stream virStreamPtr)
	(data :string)
	(nbytes size_t))

;;(defcfun "virStreamSendAll" :int
;;	(stream virStreamPtr)
;;	(handler virStreamSourceFunc)
;;	(opaque (:pointer :void)))

;;(defcfun "virStreamRecvAll" :int
;;	(stream virStreamPtr)
;;	(handler virStreamSinkFunc)
;;	(opaque (:pointer :void)))

;;(defcfun "virStreamEventAddCallback" :int
;;	(stream virStreamPtr)
;;	(events :int)
;;	(cb virStreamEventCallback)
;;	(opaque (:pointer :void))
;;	(ff virFreeCallback))

(defcfun "virStreamEventUpdateCallback" :int
	(stream virStreamPtr)
	(events :int))

(defcfun "virStreamEventRemoveCallback" :int
	(stream virStreamPtr))

(defcfun "virStreamFinish" :int
	(stream virStreamPtr))

(defcfun "virStreamAbort" :int
	(stream virStreamPtr))

(defcfun "virStreamFree" :int
	(stream virStreamPtr))
