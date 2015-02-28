(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-qemu
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Methods.
(defcfun ("virDomainQemuMonitorCommand" %virDomainQemuMonitorCommand) :int
	(domain virDomainPtr)
	(cmd :string)
	(result (:pointer :string))
	(flags :uint))

(defcfun "virDomainQemuAttach" virDomainPtr
	(domain virConnectPtr)
	(pid_value :uint)
	(flags :uint))


(defcfun "virDomainQemuAgentCommand" :string
	(domain virDomainPtr)
	(cmd :string)
	(timeout :int)
	(flags :uint))

;;(defcfun "virConnectDomainQemuMonitorEventRegister" :int
;;	(conn virConnectPtr)
;;	(domain virDomainPtr)
;;	(event :string)
;;	(cb virConnectDomainQemuMonitorEventCallback)
;;	(opaque (:pointer :void))
;;	(freecb virFreeCallback)
;;	(flags :uint))

(defcfun "virConnectDomainQemuMonitorEventDeregister" :int
	(conn virConnectPtr)
	(callbackID :int))

