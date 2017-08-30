oVirt Virtual Machine Infrastructure
====================================

The `ovirt-vm-infra` role manages the virtual machine infrastructure in oVirt.

Requirements
------------

 * Ansible version 2.3 or higher
 * Python SDK version 4 or higher

Role Variables
--------------

| Name               | Default value     |                                              |
|--------------------|-------------------|----------------------------------------------| 
| vms                | UNDEF             | List of dictionaries with virtual machine specifications.   |
| wait_for_ip        | true              | If true, the playbook should wait for the virtual machine IP reported by the guest agent.  |
| debug_vm_create    | false             | If true, logs the tasks of the virtual machine being created. The log can contain passwords. |

The `vms` list can contain following attributes:

| Name               | Default value         |                                            |
|--------------------|-----------------------|--------------------------------------------| 
| name               | UNDEF                 | Name of the virtual machine to create.     |
| tag                | UNDEF                 | Name of the tag to assign to the virtual machine.  |
| profile            | UNDEF                 | Dictionary specifying the virtual machine hardware. See the table below.  |

The `profile` dictionary can contain following attributes:

| Name               | Default value         |                                              |
|--------------------|-----------------------|----------------------------------------------|
| cluster            | Default               | Name of the cluster where the virtual machine will be created. |
| template           | Blank                 | Name of template that the virtual machine should be based on.   |
| memory             | 2GiB                  | Amount of virtual machine memory.               |
| cores              | 1                     | Number of CPU cores used by the the virtual machine.          |
| disks              | UNDEF                 | Dictionary specifying the additional virtual machine disks.    |
| nics               | UNDEF                 | List of dictionaries specifying the NICs of the virtual machine.   |
| ssh_key            | UNDEF                 | SSH key to be deployed to the virtual machine.                 |
| domain             | UNDEF                 | The domain of the virtual machine.                         |
| root_password      | UNDEF                 | The root password of the virtual machine.                      |
| high_availability  | UNDEF                 | Whether or not the node should be set highly available. |
| storage_domain     | UNDEF                 | Name of the storage domain where all virtual machine disks should be created. Considered only when template is provided.|
| state              | present               | Should the Virtual Machine be running/stopped/present/absent/suspended/next_run.|

The `disks` list can contain following attributes:

| Name               | Default value  |                                              |
|--------------------|----------------|----------------------------------------------| 
| size               | UNDEF          | The size of the additional disk. |
| name               | UNDEF          | The name of the additional disk.  |
| storage_domain     | UNDEF          | The name of storage domain where disk should be created. |
| interface          | UNDEF          | The interface of the disk. |

Dependencies
------------

 * [ovirt-affinity-groups]

Example Playbook
----------------

```yaml
---
- name: oVirt infra
  hosts: localhost
  connection: local
  gather_facts: false

  vars:
    engine_url: https://ovirt-engine.example.com/ovirt-engine/api
    engine_user: admin@internal
    engine_password: 123456
    engine_cafile: /etc/pki/ovirt-engine/ca.pem

    db_vm:
      cluster: production
      root_password: 123456
      domain: example.com
      template: rhel7
      memory: 4GiB
      cores: 2

    httpd_vm:
      cluster: production
      root_password: 123456
      domain: example.com
      template: rhel7
      memory: 2GiB
      cores: 2
      storage_domain: my_storage_domain

    vms:
      - name: apache-vm
        tag: httpd
        profile: "{{ httpd_vm }}"
      - name: postgresql-vm
        tag: db
        profile: "{{ db_vm }}"

  roles:
    - ovirt-vm-infra
```

[![asciicast](https://asciinema.org/a/111662.png)](https://asciinema.org/a/111662)

License
-------

Apache License 2.0

[ovirt-affinity-groups]: https://github.com/oVirt/ovirt-ansible/blob/master/roles/ovirt-affinity-groups/README.md
