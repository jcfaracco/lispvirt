CLISP_DIR	:= /usr/share/common-lisp

clean:
	@echo Removing files from system.
	@rm -rf ${CLISP_DIR}/source/lispvirt/ ${CLISP_DIR}/systems/lispvirt.asd
	@echo Done!

all: install

install:
	@echo Installing Lispvirt.
	@cp -rf lispvirt/ ${CLISP_DIR}/source/
	@echo Linking libraries.
	@ln -sf ${CLISP_DIR}/source/lispvirt/lispvirt.asd ${CLISP_DIR}/systems/
	@echo Done!

install_tests:
	@echo Installing Lispvirt test module.
	@cp -rf tests ${CLISP_DIR}/source/lispvirt/
	@echo Linking test libraries.
	@ln -sf ${CLISP_DIR}/source/lispvirt/tests/lispvirt-tests.asd ${CLISP_DIR}/systems/
	@echo Done!

check: test

test:
	@echo Executing tests.
	@cd tests && bash run.sh
