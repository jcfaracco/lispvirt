;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-stream.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-stream
  (:use :cl :cffi :lispvirt-ffi :lispvirt-host))

(in-package :lispvirt-stream)


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
