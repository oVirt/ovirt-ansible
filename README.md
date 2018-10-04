[![Build Status](https://travis-ci.org/oVirt/ovirt-ansible.svg?branch=master)](https://travis-ci.org/oVirt/ovirt-ansible)

# oVirt Ansible Roles

oVirt maintains multiple Ansible roles that can be deployed to easily configure and manage various parts of the oVirt infrastructure. Ansible roles provide a method of modularizing your Ansible code, in other words; it enables you to break up large playbooks into smaller reusable files. This enables you to have a separate role for each component of the infrustructure, and allows you to reuse and share roles with other users. For more information about roles, see [Creating Reusable Playbooks] in the Ansible Documentation.

Currently we have implemented following Ansible roles:

* [oVirt.cluster-upgrade] - easily upgrade your oVirt clusters, host by host.
* [oVirt.disaster-recovery] - plan, failover and failback oVirt in Disaster Recovery scenarios.
* [oVirt.engine-setup] - setup your oVirt Engine via Ansible.
* [oVirt.hosted-engine-setup] - setup your oVirt Hosted-Engine via Ansible.
* [oVirt.infra] - setup a complete oVirt setup (data centers, clusters, hosts, networks...) via this role.
* [oVirt.image-template] - easily create VM templates (via Glance or QCOW2 download)
* [oVirt.manageiq] - install and configure a ManageIQ (or CloudForms) VM appliance on your oVirt!
* [oVirt.repositories] - set up the required oVirt repositories on your hosts.
* [oVirt.vm-infra] - configure a complete VM setup (create and configure VMs and their properties)
* [oVirt.v2v-conversion-host] - define a host as a target for VMware to oVirt migration.
* [oVirt.shutdown-env] - shutdown the whole environment in a clean and ordered way.

## Installing the oVirt Roles

There are multiple methods to install the Ansible roles on your Ansible server.

### Installing from a Package

__Note:__ You must have the official oVirt repository enabled. For more information see the [oVirt Deployment Options].

The Ansible roles are packaged into an RPM file that can be installed from the command line.

Run the following command to install all roles:
```
# yum install ovirt-ansible-roles
```
Run the following command to install specific role:
```
# yum install ovirt-ansible-infra
```
To search all available roles you can execute following command:
```
# yum search ovirt-ansible
```
By default the roles will be installed to `/usr/share/ansible/roles`.

The structure of the ovirt-ansible-roles package is as follows:
*    `/usr/share/ansible/roles` - stores the roles.
*    `/usr/share/ansible/roles/{role_name}` - stores the specific role.
*    `/usr/share/doc/ovirt-ansible-roles/` - stores the examples, a basic overview and the licence.
*    `/usr/share/doc/{role_name}` - stores the documentation and examples specific to the role.

### Installing using Galaxy

Ansible provides a command line utility to install Roles directory from the Galaxy Repository. See the [Galaxy] website for more information about Galaxy.

To install the roles using Galaxy, run the following from the command line:
```
# ansible-galaxy install oVirt.ovirt-ansible-roles
```
To install the specific role using Galaxy, run the following from the command line:
```
# ansible-galaxy install oVirt.infra
```
All roles are available under [oVirt organization] on Ansible Galaxy.

By default the roles will be installed to `/etc/ansible/roles`.

The structure of ovirt.ovirt-ansible-roles is as follows:
* `/etc/ansible/roles/` - stores the roles.
* `/etc/ansible/roles/{role_name}` - stores the specifc role.
* `/etc/ansible/roles/{role_name}/examples` - stores the examples, a basic overview

## Getting Started

This section will guide you through creating and running your playbook against the engine.
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
    compatibility_version: 4.2

  roles:
    - oVirt.infra

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

[oVirt.infra]: https://github.com/oVirt/ovirt-ansible-infra/blob/master/README.md
[oVirt.image-template]: https://github.com/oVirt/ovirt-ansible-image-template/blob/master/README.md
[oVirt.vm-infra]: https://github.com/oVirt/ovirt-ansible-vm-infra/blob/master/README.md
[oVirt.cluster-upgrade]: https://github.com/oVirt/ovirt-ansible-cluster-upgrade/blob/master/README.md
[oVirt.manageiq]: https://github.com/oVirt/ovirt-ansible-manageiq/blob/master/README.md
[Creating Reusable Playbooks]: http://docs.ansible.com/ansible/latest/playbooks_reuse.html
[oVirt Deployment Options]: https://www.ovirt.org/download/
[Galaxy]: https://galaxy.ansible.com/
[oVirt organization]: https://galaxy.ansible.com/oVirt/
[oVirt.disaster-recovery]: https://github.com/oVirt/ovirt-ansible-disaster-recovery/blob/master/README.md
[oVirt.engine-setup]: https://github.com/oVirt/ovirt-ansible-engine-setup/blob/master/README.md
[oVirt.repositories]: https://github.com/oVirt/ovirt-ansible-repositories/blob/master/README.md
[oVirt.v2v-conversion-host]: https://github.com/oVirt/ovirt-ansible-v2v-conversion-host/blob/master/README.md
[oVirt.hosted-engine-setup]: https://github.com/oVirt/ovirt-ansible-hosted-engine-setup/blob/master/README.md
[oVirt.shutdown-env]: https://github.com/oVirt/ovirt-ansible-shutdown-env/blob/master/README.md
