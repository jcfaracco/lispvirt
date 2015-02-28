(defsystem :lispvirt-tests
	:name "lispvirt-tests"
	:author "Julio Faracco <jcfaracco@gmail.com>"
	:version "1.0.0"
	:license "Public Domain"
	:components ((:file "lispvirt-tests"))
	:depends-on (:lispvirt :cffi))

