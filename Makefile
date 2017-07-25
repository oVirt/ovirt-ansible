# ====================================================================
# Copyright 2017 Red Hat, Inc. and/or its affiliates.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ====================================================================

#
# CUSTOMIZATION-BEGIN
#
PACKAGE_NAME=ovirt-ansible-roles
PREFIX=/usr/local
SYSCONF_DIR=$(PREFIX)/etc
DATAROOT_DIR=$(PREFIX)/share
DOC_DIR=$(DATAROOT_DIR)/doc
PKG_DATA_DIR=$(DATAROOT_DIR)/$(PACKAGE_NAME)
PKG_DOC_DIR=$(DATAROOT_DIR)/doc/${PACKAGE_NAME}
ANSIBLE_DOC_DIR=$(DATAROOT_DIR)/doc/ansible/roles
ANSIBLE_DATA_DIR=${PKG_DATA_DIR}/roles

#
# CUSTOMIZATION-END
#

include version.mak
RPM_VERSION=$(VERSION)
PACKAGE_VERSION=$(VERSION)$(if $(MILESTONE),_$(MILESTONE))
DISPLAY_VERSION=$(PACKAGE_VERSION)

TARBALL=$(PACKAGE_NAME)-$(PACKAGE_VERSION).tar.gz

.SUFFIXES:
.SUFFIXES: .in

.in:
	sed \
	-e "s|@DATAROOT_DIR@|$(DATAROOT_DIR)|g" \
	-e "s|@PKG_DATA_DIR=@|$(PKG_DATA_DIR=)|g" \
	-e "s|@RPM_VERSION@|$(RPM_VERSION)|g" \
	-e "s|@RPM_RELEASE@|$(RPM_RELEASE)|g" \
	-e "s|@PACKAGE_NAME@|$(PACKAGE_NAME)|g" \
	-e "s|@PACKAGE_VERSION@|$(PACKAGE_VERSION)|g" \
	-e "s|@DISPLAY_VERSION@|$(DISPLAY_VERSION)|g" \
	-e "s|@VERSION_MAJOR@|$(VERSION_MAJOR)|g" \
	-e "s|@VERSION_MINOR@|$(VERSION_MINOR)|g" \
	-e "s|@VERSION_PATCH_LEVEL@|$(VERSION_PATCH_LEVEL)|g" \
	$< > $@


.PHONY: ovirt-ansible-roles.spec.in

dist:	ovirt-ansible-roles.spec
	git ls-files | tar --files-from /proc/self/fd/0 -czf "$(TARBALL)" ovirt-ansible-roles.spec
	@echo
	@echo For distro specific packaging refer to http://www.ovirt.org/Build_Binary_Package
	@echo

copy-recursive:
	( cd "$(SOURCEDIR)" && find . -type d -printf '%P\n' ) | while read d; do \
		install -d -m 755 "$(TARGETDIR)/$${d}"; \
	done
	( \
		cd "$(SOURCEDIR)" && find . -type f -printf '%P\n' | \
		while read f; do echo "$${f}"; done \
	) | while read f; do \
		src="$(SOURCEDIR)/$${f}"; \
		dst="$(TARGETDIR)/$${f}"; \
		[ -x "$${src}" ] && MASK=0755 || MASK=0644; \
		install -T -m "$${MASK}" "$${src}" "$${dst}"; \
	done

copy-doc:
	( cd "$(SOURCEDIR)" && find . -maxdepth 1 -type d -printf '%P\n' ) | while read d; do \
		install -d -m 755 "$(TARGETDIR)/$${d}"; \
	done
	( \
	  cd "$(SOURCEDIR)" && find . -maxdepth 2 -name README.md -type f -printf '%P\n' | \
          while read f; do echo "$${f}"; done \
        ) | while read f; do \
		src="$(SOURCEDIR)/$${f}"; \
		dst="$(TARGETDIR)/$${f}"; \
		[ -x "$${src}" ] && MASK=0755 || MASK=0644; \
		install -T -m "$${MASK}" "$${src}" "$${dst}"; \
	  done

copy-examples:
	( cd "$(SOURCEDIR)" && find . -maxdepth 1 -type d -printf '%P\n' ) | while read d; do \
		install -d -m 755 "$(TARGETDIR)/$${d}"; \
	done
	( \
	  cd "$(SOURCEDIR)" && find . -maxdepth 1 -name '*yml' -type f -printf '%P\n' | \
          while read f; do echo "$${f}"; done \
        ) | while read f; do \
		src="$(SOURCEDIR)/$${f}"; \
		dst="$(TARGETDIR)/$${f}"; \
		[ -x "$${src}" ] && MASK=0755 || MASK=0644; \
		install -T -m "$${MASK}" "$${src}" "$${dst}"; \
	  done

create-license:
	cp -f LICENSE "${DESTDIR}$(PKG_DOC_DIR)/"

create-readme:
	cp -f README.md "${DESTDIR}$(PKG_DOC_DIR)/"

create-symlink:
	mkdir -p ${DESTDIR}$(PKG_DATA_DIR)/playbooks/
	ln -fs "$(ANSIBLE_DATA_DIR)" "${DESTDIR}$(PKG_DATA_DIR)/playbooks/"

install: $(NULL)
	$(MAKE) copy-recursive SOURCEDIR=roles TARGETDIR="${DESTDIR}$(ANSIBLE_DATA_DIR)"
	$(MAKE) copy-recursive SOURCEDIR=playbooks TARGETDIR="${DESTDIR}$(PKG_DATA_DIR)/playbooks"
	$(MAKE) copy-doc SOURCEDIR=roles TARGETDIR="${DESTDIR}$(ANSIBLE_DOC_DIR)"
	$(MAKE) copy-examples SOURCEDIR=examples TARGETDIR="${DESTDIR}$(PKG_DOC_DIR)/examples"
	$(MAKE) create-license
	$(MAKE) create-readme
	$(MAKE) create-symlink
