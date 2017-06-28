oVirt virtual machine infrastructure
====================================

This role manage the virtual machine infrastructure in oVirt.

Requirements
------------

 * Ansible version 2.3 or higher
 * Python SDK version 4 or higher

Role Variables
--------------

| Name               | Default value     |                                              |
|--------------------|-------------------|----------------------------------------------| 
| vms                | UNDEF             | List of dictionaries with VM specification   |
| wait_for_ip        | true              | Whether the playbook should wait for VMs IP, reported by guest agent  |
| debug_vm_create    | false             | Whether the log of VM creating task should be logged (it can contain passwords) |

The item in `vms` list can contain following attributes:

| Name               | Default value         |                                            |
|--------------------|-----------------------|--------------------------------------------| 
| name               | UNDEF                 | Name of the VM to be created               |
| tag                | UNDEF                 | Name of the tag to be assigned to VM       |
| profile            | UNDEF                 | Dictionary specifying the VM HW see below  |

The `profile` dictionary can contain following attributes:

| Name               | Default value         |                                              |
|--------------------|-----------------------|----------------------------------------------| 
| cluster            | Default               | Name of the cluster where VM will be created |
| template           | Blank                 | Name of template the VM should be based on   |
| memory             | 2GiB                  | Amount of the memory of the VM               |
| cores              | 1                     | Number of CPU cores of the VM                |
| disks              | UNDEF                 | Dictionary specifying additional VM disks    |
| nics               | UNDEF                 | List of dictionaries specifying NICs of VM   |
| ssh_key            | UNDEF                 | SSH key to be deployed to VM                 |
| domain             | UNDEF                 | The domain of the VM                         |
| root_password      | UNDEF                 | root password of the VM                      |

The item in `disks` list can contain following attributes:

| Name               | Default value  |                                              |
|--------------------|----------------|----------------------------------------------| 
| size               | UNDEF          | The size of the additional disk |
| name               | UNDEF          | The name of the additional disk  |
| storage_domain     | UNDEF          | The name of storage domain where disk should be created |
| interface          | UNDEF          | The interface of the disk |

Dependencies
------------

No.

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
      disks: []

    httpd_vm:
      cluster: production
      root_password: 123456
      domain: example.com
      template: rhel7
      memory: 2GiB
      cores: 2
      disks: []

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
