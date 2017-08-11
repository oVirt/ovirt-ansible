[![Build Status](https://travis-ci.org/oVirt/ovirt-ansible.svg?branch=master)](https://travis-ci.org/oVirt/ovirt-ansible)

# oVirt Ansible Roles

oVirt maintains multiple Ansible roles that can be deployed to easily configure and manage various parts of the oVirt infrustructure. Ansible roles provide a method of modularizing your Ansible code, in other words; it enables you to break up large playbooks into smaller reusable files. This enables you to have a separate role for each component of the infrustructure, and allows you to reuse and share roles with other users. For more information about roles, see [Creating Reusable Playbooks] in the Ansible Documentation.

The oVirt roles can be divided into two types of roles: Logical roles and Component roles.

## Logical Roles

Logical roles are used to group component roles, or implement specific scenarios on top of
oVirt components.

* [ovirt-cluster-upgrade]
* [ovirt-infra]
* [ovirt-image-template]
* [ovirt-manageiq]
* [ovirt-vm-infra]

## Component Roles

Component roles enable you to manage the lifecycle of a specific oVirt component.

The [ovirt-infra] logical role implements the following helper component roles:

 * [ovirt-aaa-jdbc]
 * [ovirt-clusters]
 * [ovirt-datacenters]
 * [ovirt-hosts]
 * [ovirt-networks]
 * [ovirt-permissions]
 * [ovirt-storages]

The [ovirt-vm-infra] role includes the following helper component role:

 * [ovirt-affinity-groups]
 
## Installing the oVirt Roles

There are multiple methods to install the Ansible roles on your Ansible server.

### Installing from a Package

__Note:__ You must have the official oVirt repository enabled. For more information see the [oVirt Deployment Options].

The Ansible roles are packaged into an RPM file that can be installed from the command line.

Run the following command:
```
# yum install ovirt-ansible-roles 
```
By default the roles will be installed to `/usr/share/ansible/roles`.

### Installing using Galaxy

Ansible provides a command line utility to install Roles directory from the Galaxy Repository. See the [Galaxy] website for more information about Galaxy.

To install the role using Galaxy, run the following from the command line:
```
# ansible-galaxy install ovirt.ovirt-ansible-roles
```
By default the roles will be installed to `/etc/ansible/roles`.

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
[ovirt-affinity-groups]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-affinity-groups/README.md
[Creating Reusable Playbooks]: http://docs.ansible.com/ansible/latest/playbooks_reuse.html
[oVirt Deployment Options]: https://www.ovirt.org/download/
[Galaxy]: https://galaxy.ansible.com/
