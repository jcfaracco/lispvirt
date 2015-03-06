;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt.asd is part of Lispvirt.
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

(defsystem :lispvirt
  :name "lispvirt"
  :author "Julio Faracco <jcfaracco@gmail.com>"
  :version "1.0.0"
  :license "Public Domain"
  :depends-on (cffi)
  :serial t
  :components ((:module src
		:serial t
		:components 
			((:file "lispvirt")
			(:file "lispvirt-ffi")
			(:file "lispvirt-host" :depends-on ("lispvirt-ffi"))
			(:file "lispvirt-event" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-domain" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-lxc" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-network" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-nwfilter" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-nodedev" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-storage" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-secret" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-interface" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-stream" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-error" :depends-on ("lispvirt-ffi" "lispvirt-host"))
			(:file "lispvirt-domain-snapshot" :depends-on ("lispvirt-ffi" "lispvirt-host" "lispvirt-domain"))
			(:file "lispvirt-qemu" :depends-on ("lispvirt-ffi" "lispvirt-host" "lispvirt-domain"))))))


