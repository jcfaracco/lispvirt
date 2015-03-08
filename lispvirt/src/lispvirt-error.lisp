;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-error.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-error
  (:use :cl :cffi :lispvirt-host)
  (:export virErrorPtr))

(in-package :lispvirt-error)


;; Definitions of strucutres for Storage.
(defcstruct virError)

(defcenum virErrorLevel
	(:VIR_ERR_NONE 0)
	(:VIR_ERR_WARNING 1)        ;; A simple warning.
	(:VIR_ERR_ERROR 2))         ;; An error.

(defcenum virErrorDomain
	(:VIR_FROM_NONE 0)
	(:VIR_FROM_XEN 1)               ;; Error at Xen hypervisor layer.
	(:VIR_FROM_XEND 2)              ;; Error at connection with xend daemon.
	(:VIR_FROM_XENSTORE 3)          ;; Error at connection with xen store.
	(:VIR_FROM_SEXPR 4)             ;; Error in the S-Expression code.

	(:VIR_FROM_XML 5)               ;; Error in the XML code.
	(:VIR_FROM_DOM 6)               ;; Error when operating on a domain.
	(:VIR_FROM_RPC 7)               ;; Error in the XML-RPC code.
	(:VIR_FROM_PROXY 8)             ;; Error in the proxy code; unused since 0.8.6.
	(:VIR_FROM_CONF 9)              ;; Error in the configuration file handling.

	(:VIR_FROM_QEMU 10)             ;; Error at the QEMU daemon.
	(:VIR_FROM_NET 11)              ;; Error when operating on a network.
	(:VIR_FROM_TEST 12)             ;; Error from test driver.
	(:VIR_FROM_REMOTE 13)           ;; Error from remote driver.
	(:VIR_FROM_OPENVZ 14)           ;; Error from OpenVZ driver.

	(:VIR_FROM_XENXM 15)            ;; Error at Xen XM layer.
	(:VIR_FROM_STATS_LINUX 16)      ;; Error in the Linux Stats code.
	(:VIR_FROM_LXC 17)              ;; Error from Linux Container driver.
	(:VIR_FROM_STORAGE 18)          ;; Error from storage driver.
	(:VIR_FROM_NETWORK 19)          ;; Error from network config.

	(:VIR_FROM_DOMAIN 20)           ;; Error from domain config.
	(:VIR_FROM_UML 21)              ;; Error at the UML driver.
	(:VIR_FROM_NODEDEV 22)          ;; Error from node device monitor.
	(:VIR_FROM_XEN_INOTIFY 23)      ;; Error from xen inotify layer.
	(:VIR_FROM_SECURITY 24)         ;; Error from security framework.

	(:VIR_FROM_VBOX 25)             ;; Error from VirtualBox driver.
	(:VIR_FROM_INTERFACE 26)        ;; Error when operating on an interface.
	(:VIR_FROM_ONE 27)              ;; The OpenNebula driver no longer exists. Retained for ABI/API compat only.
	(:VIR_FROM_ESX 28)              ;; Error from ESX driver.
	(:VIR_FROM_PHYP 29)             ;; Error from IBM power hypervisor.

	(:VIR_FROM_SECRET 30)           ;; Error from secret storage.
	(:VIR_FROM_CPU 31)              ;; Error from CPU driver.
	(:VIR_FROM_XENAPI 32)           ;; Error from XenAPI.
	(:VIR_FROM_NWFILTER 33)         ;; Error from network filter driver.
	(:VIR_FROM_HOOK 34)             ;; Error from Synchronous hooks.

	(:VIR_FROM_DOMAIN_SNAPSHOT 35)  ;; Error from domain snapshot.
	(:VIR_FROM_AUDIT 36)            ;; Error from auditing subsystem.
	(:VIR_FROM_SYSINFO 37)          ;; Error from sysinfo/SMBIOS.
	(:VIR_FROM_STREAMS 38)          ;; Error from I/O streams.
	(:VIR_FROM_VMWARE 39)           ;; Error from VMware driver.

	(:VIR_FROM_EVENT 40)            ;; Error from event loop impl.
	(:VIR_FROM_LIBXL 41)            ;; Error from libxenlight driver.
	(:VIR_FROM_LOCKING 42)          ;; Error from lock manager.
	(:VIR_FROM_HYPERV 43)           ;; Error from Hyper-V driver.
	(:VIR_FROM_CAPABILITIES 44)     ;; Error from capabilities.

	(:VIR_FROM_URI 45)              ;; Error from URI handling.
	(:VIR_FROM_AUTH 46)             ;; Error from auth handling.
	(:VIR_FROM_DBUS 47)             ;; Error from DBus.
	(:VIR_FROM_PARALLELS 48)        ;; Error from Parallels.
	(:VIR_FROM_DEVICE 49)           ;; Error from Device.

	(:VIR_FROM_SSH 50)              ;; Error from libssh2 connection transport.
	(:VIR_FROM_LOCKSPACE 51)        ;; Error from lockspace.
	(:VIR_FROM_INITCTL 52)          ;; Error from initctl device communication.
	(:VIR_FROM_IDENTITY 53)         ;; Error from identity code.
	(:VIR_FROM_CGROUP 54)           ;; Error from cgroups.

	(:VIR_FROM_ACCESS 55)           ;; Error from access control manager.
	(:VIR_FROM_SYSTEMD 56)          ;; Error from systemd code.
	(:VIR_FROM_BHYVE 57)            ;; Error from bhyve driver.
	(:VIR_FROM_CRYPTO 58)           ;; Error from crypto code.
	(:VIR_FROM_FIREWALL 59)         ;; Error from firewall.

	(:VIR_FROM_POLKIT 60)           ;; Error from polkit code.
	(:VIR_ERR_DOMAIN_LAST))

(defcenum virErrorNumber
	(:VIR_ERR_OK 0)
	(:VIR_ERR_INTERNAL_ERROR 1)         ;; internal error.
	(:VIR_ERR_NO_MEMORY 2)              ;; memory allocation failure.
	(:VIR_ERR_NO_SUPPORT 3)             ;; no support for this function.
	(:VIR_ERR_UNKNOWN_HOST 4)           ;; could not resolve hostname.
	(:VIR_ERR_NO_CONNECT 5)             ;; can't connect to hypervisor.
	(:VIR_ERR_INVALID_CONN 6)           ;; invalid connection object.
	(:VIR_ERR_INVALID_DOMAIN 7)         ;; invalid domain object.
	(:VIR_ERR_INVALID_ARG 8)            ;; invalid function argument.
	(:VIR_ERR_OPERATION_FAILED 9)       ;; a command to hypervisor failed.
	(:VIR_ERR_GET_FAILED 10)            ;; a HTTP GET command to failed.
	(:VIR_ERR_POST_FAILED 11)           ;; a HTTP POST command to failed.
	(:VIR_ERR_HTTP_ERROR 12)            ;; unexpected HTTP error code.
	(:VIR_ERR_SEXPR_SERIAL 13)          ;; failure to serialize an S-Expr.
	(:VIR_ERR_NO_XEN 14)                ;; could not open Xen hypervisor control.
	(:VIR_ERR_XEN_CALL 15)              ;; failure doing an hypervisor call.
	(:VIR_ERR_OS_TYPE 16)               ;; unknown OS type.
	(:VIR_ERR_NO_KERNEL 17)             ;; missing kernel information.
	(:VIR_ERR_NO_ROOT 18)               ;; missing root device information.
	(:VIR_ERR_NO_SOURCE 19)             ;; missing source device information.
	(:VIR_ERR_NO_TARGET 20)             ;; missing target device information.
	(:VIR_ERR_NO_NAME 21)               ;; missing domain name information.
	(:VIR_ERR_NO_OS 22)                 ;; missing domain OS information.
	(:VIR_ERR_NO_DEVICE 23)             ;; missing domain devices information.
	(:VIR_ERR_NO_XENSTORE 24)           ;; could not open Xen Store control.
	(:VIR_ERR_DRIVER_FULL 25)           ;; too many drivers registered.
	(:VIR_ERR_CALL_FAILED 26)           ;; not supported by the drivers (DEPRECATED).
	(:VIR_ERR_XML_ERROR 27)             ;; an XML description is not well formed or broken.
	(:VIR_ERR_DOM_EXIST 28)             ;; the domain already exist.
	(:VIR_ERR_OPERATION_DENIED 29)      ;; operation forbidden on read-only connections.
	(:VIR_ERR_OPEN_FAILED 30)           ;; failed to open a conf file.
	(:VIR_ERR_READ_FAILED 31)           ;; failed to read a conf file.
	(:VIR_ERR_PARSE_FAILED 32)          ;; failed to parse a conf file.
	(:VIR_ERR_CONF_SYNTAX 33)           ;; failed to parse the syntax of a conf file.
	(:VIR_ERR_WRITE_FAILED 34)          ;; failed to write a conf file.
	(:VIR_ERR_XML_DETAIL 35)            ;; detail of an XML error.
	(:VIR_ERR_INVALID_NETWORK 36))      ;; invalid network object.


;; Pointers mapping to structures.
(defctype virErrorPtr (:pointer virError))


;; Methods.
(defcfun "virGetLastError" virErrorPtr)

(defcfun "virSaveLastError" virErrorPtr)

(defcfun "virResetLastError" :void)

(defcfun "virResetError" :void
	(err virErrorPtr))

(defcfun "virFreeError" :void
	(err virErrorPtr))

(defcfun "virGetLastErrorMessage" :string)

(defcfun "virConnGetLastError" virErrorPtr
	(conn virConnectPtr conn))

(defcfun "virConnResetLastError" :void
	(conn virConnectPtr conn))

(defcfun "virCopyLastError" :int
	(to virErrorPtr))

(defcfun "virDefaultErrorFunc" :void
	(err virErrorPtr))

;;(defcfun "virSetErrorFunc" :void
;;	(userData (:pointer :void))
;;	(handler virErrorFunc handler))

;;(defcfun "virConnSetErrorFunc" :void
;;	(conn virConnectPtr)
;;	(userData (:pointer :void))
;;	(handler virErrorFunc))

(defcfun "virConnCopyLastError" :int
	(conn virConnectPtr)
	(to virErrorPtr))
