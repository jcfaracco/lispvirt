;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-qemu.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-qemu
  (:use :cl :cffi :lispvirt-host :lispvirt-domain)
  (:export :virDomainQemuMonitorCommand
	   :virDomainQemuAttach
	   :virDomainQemuAgentCommand
	   :virConnectDomainQemuMonitorEventDeregister))

(in-package :lispvirt-qemu)


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

