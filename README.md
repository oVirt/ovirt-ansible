[![Build Status](https://travis-ci.org/oVirt/ovirt-ansible.svg?branch=master)](https://travis-ci.org/oVirt/ovirt-ansible)

# oVirt Ansible

This repo contains various Ansible roles to manage oVirt.

## Logical roles

Logical roles can group the component roles or implement specific scenario on top of
more oVirt components.

* [ovirt-cluster-upgrade]
* [ovirt-infra]
* [ovirt-image-template]
* [ovirt-manageiq]
* [ovirt-vm-infra]

## Component roles

Component role provides a lifecycle of specific oVirt component.

[ovirt-infra] role implements following helper component roles:

 * [ovirt-aaa-jdbc]
 * [ovirt-clusters]
 * [ovirt-datacenters]
 * [ovirt-hosts]
 * [ovirt-networks]
 * [ovirt-permissions]
 * [ovirt-storages]

[ovirt-infra]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-infra/README.md
[ovirt-image-template]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-image-template/README.md
[ovirt-vm-infra]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-vm-infra/README.md
[ovirt-aaa-jdbc]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-aaa-jdbc/README.md
[ovirt-clusters]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-clusters/README.md
[ovirt-datacenters]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-datacenters/README.md
[ovirt-hosts]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-hosts/README.md
[ovirt-networks]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-networks/README.md
[ovirt-permissions]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-permissions/README.md
[ovirt-storages]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-storages/README.md
[ovirt-cluster-upgrade]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-cluster-upgrade/README.md
[ovirt-manageiq]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-manageiq/README.md
