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
	   :virConnectDomainQemuMonitorEventDeregister
	   :virDomainQemuMonitorCommandFlags
	   :virDomainQemuAgentCommandTimeoutValues
	   :virConnectDomainQemuMonitorEventRegisterFlags
	   :virConnectDomainQemuMonitorEventCallback))

(in-package :lispvirt-qemu)


(defcenum virDomainQemuMonitorCommandFlags
	(:VIR_DOMAIN_QEMU_MONITOR_COMMAND_DEFAULT 0)
	(:VIR_DOMAIN_QEMU_MONITOR_COMMAND_HMP 1))	;; cmd is in HMP.

(defcenum virDomainQemuAgentCommandTimeoutValues
	(:VIR_DOMAIN_QEMU_AGENT_COMMAND_MIN -2)
	(:VIR_DOMAIN_QEMU_AGENT_COMMAND_BLOCK -2)
	(:VIR_DOMAIN_QEMU_AGENT_COMMAND_DEFAULT -1)
	(:VIR_DOMAIN_QEMU_AGENT_COMMAND_NOWAIT 0))

(defcenum virConnectDomainQemuMonitorEventRegisterFlags
	(:VIR_CONNECT_DOMAIN_QEMU_MONITOR_EVENT_REGISTER_REGEX 1)	;; Event filter is a regex rather than a literal string.
	(:VIR_CONNECT_DOMAIN_QEMU_MONITOR_EVENT_REGISTER_NOCASE 2))	;; Event filter is case insensitive.


;; Pointers mapping to structures.
(defctype virConnectDomainQemuMonitorEventCallback :pointer)


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

(defcfun "virConnectDomainQemuMonitorEventRegister" :int
	(conn virConnectPtr)
	(domain virDomainPtr)
	(event :string)
	(cb virConnectDomainQemuMonitorEventCallback)
	(opaque (:pointer :void))
	(freecb virFreeCallback)
	(flags :uint))

(defcfun "virConnectDomainQemuMonitorEventDeregister" :int
	(conn virConnectPtr)
	(callbackID :int))

