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


