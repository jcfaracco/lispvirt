(asdf:load-system :lispvirt)

(in-package lispvirt-domain)

;; Example methods for domain.
(defun list-all-active-domains (string)
        (let ((conn (virConnectOpen string)))
                (virConnectListDomains conn (virConnectNumOfDomains conn))))

;; Running methods.
(list-all-active-domains "qemu:///system")
