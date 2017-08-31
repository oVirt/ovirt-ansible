[![Build Status](https://travis-ci.org/oVirt/ovirt-ansible.svg?branch=master)](https://travis-ci.org/oVirt/ovirt-ansible)

# oVirt Ansible Roles

oVirt maintains multiple Ansible roles that can be deployed to easily configure and manage various parts of the oVirt infrastructure. Ansible roles provide a method of modularizing your Ansible code, in other words; it enables you to break up large playbooks into smaller reusable files. This enables you to have a separate role for each component of the infrustructure, and allows you to reuse and share roles with other users. For more information about roles, see [Creating Reusable Playbooks] in the Ansible Documentation.

The oVirt roles can be divided into two types of roles: Logical roles and Component roles.

## Logical Roles

Logical roles are used to group component roles, or implement specific scenarios on top of
oVirt components.

* [ovirt-cluster-upgrade]
* [ovirt-host-deploy]
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
 * [ovirt-host-deploy-firewalld]
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

The structure of the ovirt-ansible-roles package is as follows:
*    `/usr/share/ansible/roles` - stores the roles.
*    `/usr/share/doc/ovirt-ansible-roles/` - stores the examples, a basic overview and the licence.
*    `/usr/share/doc/ansible/roles/{role_name}` - stores the documentation specific to the role.

### Installing using Galaxy

Ansible provides a command line utility to install Roles directory from the Galaxy Repository. See the [Galaxy] website for more information about Galaxy.

To install the role using Galaxy, run the following from the command line:
```
# ansible-galaxy install ovirt.ovirt-ansible-roles
```
By default the roles will be installed to `/etc/ansible/roles`.

The structure of ovirt.ovirt-ansible-roles is as follows:
* `/etc/ansible/roles/ovirt.ovirt-ansible-roles/roles` - stores the roles.
* `/etc/ansible/roles/ovirt.ovirt-ansible-roles/examples` - stores the examples, a basic overview and the licence.
* `/etc/ansible/roles/ovirt.ovirt-ansible-roles/roles/{role_name}` - stores the documentation specific to the role.

## Getting Started

This section will guide you through creating and running your playbook against the engine.

By default, Ansible only searches for roles in the `/etc/ansible/roles/` directory and your current working directory. To change the directory where Ansible looks for roles, modify the `roles_path` option of the `[defaults]` section in the `ansible.cfg` configuration file. The default location of this file is `/etc/ansible/ansible.cfg`. You may need to update the `roles_path` option if you installed the roles with the package.

The following example connects to the engine on the local host and creates a new data center. The current working directory is `/tmp`.

**Note:** Ensure you have Python SDK installed on the machine running the playbook.

1) Create a file in your working directory to store the engine's user password:
```
$ cat passwords.yml
---
engine_password: youruserpassword
```

2) Encrypt the user password. You will be asked for a vault password.
```
$ ansible-vault encrypt passwords.yml
New Vault password: 
Confirm New Vault password: 
```
3) Create a file that contains engine details such as the url, certificate, and user.
```
$ cat engine_vars.yml 
---
engine_url: https://example.engine.redhat.com/ovirt-engine/api
engine_user: admin@internal
engine_cafile: /etc/pki/ovirt-engine/ca.pem
```
**Note:** If you prefer, these variables can be added directly to the playbook instead.

4) Create your playbook. To simplify this, you can copy and modify an example in `/etc/ansible/roles/ovirt.ovirt-ansible-roles/examples` or `/usr/share/doc/ovirt-ansible-roles/examples` depending on the method used to install the roles:
```yaml
$ cat ovirt_infra.yml
---
- name: oVirt infra
  hosts: localhost
  connection: local
  gather_facts: false

  vars_files:
    # Contains variables to connect to the engine
    - engine_vars.yml
    # Contains encrypted `engine_password` variable using ansible-vault
    - passwords.yml

  pre_tasks:
    - name: Login to oVirt
      ovirt_auth:
        url: "{{ engine_url }}"
        username: "{{ engine_user }}"
        password: "{{ engine_password }}"
        ca_file: "{{ engine_cafile | default(omit) }}"
        insecure: "{{ engine_insecure | default(true) }}"
      tags:
        - always

  vars:
    data_center_name: mydatacenter
    data_center_description: mydatacenter
    data_center_local: false
    compatibility_version: 4.1

  roles:
    - ovirt-datacenters

  post_tasks:
    - name: Logout from oVirt
      ovirt_auth:
        state: absent
        ovirt_auth: "{{ ovirt_auth }}"
      tags:
        - always
```

5) Run the playbook.
```
$ ansible-playbook --ask-vault-pass ovirt_infra.yml
```
After the ansible-playbook playbook completes you will have a new data center named `mydatacenter`.

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
[ovirt-host-deploy]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-host-deploy/README.md
[ovirt-host-deploy-firewalld]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-host-deploy-firewalld/README.md
[Creating Reusable Playbooks]: http://docs.ansible.com/ansible/latest/playbooks_reuse.html
[oVirt Deployment Options]: https://www.ovirt.org/download/
[Galaxy]: https://galaxy.ansible.com/
