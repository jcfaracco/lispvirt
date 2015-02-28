(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-event
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Definitions of strucutres for Storage.
(defcenum virEventHandleType
	(:VIR_EVENT_HANDLE_READABLE 1)
	(:VIR_EVENT_HANDLE_WRITABLE 2)
	(:VIR_EVENT_HANDLE_ERROR 4)
	(:VIR_EVENT_HANDLE_HANGUP 8))


;; Methods
;;(defcfun "virEventRegisterImpl" :void
;;	(addHandle virEventAddHandleFunc)
;;	(updateHandle virEventUpdateHandleFunc)
;;	(removeHandle virEventRemoveHandleFunc)
;;	(addTimeout virEventAddTimeoutFunc)
;;	(updateTimeout virEventUpdateTimeoutFunc)
;;	(removeTimeout virEventRemoveTimeoutFunc))

(defcfun "virEventRegisterDefaultImpl" :int)

(defcfun "virEventRunDefaultImpl" :int)

;;(defcfun "virEventAddHandle" :int
;;	(fd :int)
;;	(events :int)
;;	(cb virEventHandleCallback)
;;	(opaque (:pointer :void))
;;	(ff virFreeCallback))

(defcfun "virEventUpdateHandle" :void
	(watch :int)
	(events :int))

(defcfun "virEventRemoveHandle" :int
	(watch :int))

;;(defcfun "virEventAddTimeout" :int
;;	(frequency :int)
;;	(cb virEventTimeoutCallback)
;;	(opaque (:pointer :void))
;;	(ff virFreeCallback))

(defcfun "virEventUpdateTimeout" :void
	(timer :int)
	(frequency :int))

(defcfun "virEventRemoveTimeout" :int
	(timer :int))
