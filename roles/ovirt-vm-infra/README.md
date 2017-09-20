oVirt Virtual Machine Infrastructure
====================================

The `ovirt-vm-infra` role manages the virtual machine infrastructure in oVirt.

Requirements
------------

 * Ansible version 2.3 or higher
 * Python SDK version 4 or higher

Role Variables
--------------

| Name                           | Default value |                                              |
|--------------------------------|---------------|----------------------------------------------| 
| vms                            | UNDEF         | List of dictionaries with virtual machine specifications.   |
| wait_for_ip                    | true          | If true, the playbook should wait for the virtual machine IP reported by the guest agent.  |
| debug_vm_create                | false         | If true, logs the tasks of the virtual machine being created. The log can contain passwords. |
| vm_infra_create_single_timeout | 180           | Time in seconds to wait for VM to be created and started (if state is running). |
| vm_infra_create_poll_interval  | 15            | Polling interval. Time in seconds to wait between check of state of VM.  |
| vm_infra_create_all_timeout    | vm_infra_create_single_timeout * (vms | length) | Total time to wait for all VMs to be created/started. |
| vm_infra_wait_for_ip_retries   | 5             | Number of retries to check if VM is reporting it's IP address. |
| vm_infra_wait_for_ip_delay     | 5             | Polling interval of IP address. Time in seconds to wait between check if VM reports IP address. |


The `vms` list can contain following attributes:

| Name               | Default value         |                                            |
|--------------------|-----------------------|--------------------------------------------| 
| name               | UNDEF                 | Name of the virtual machine to create.     |
| tag                | UNDEF                 | Name of the tag to assign to the virtual machine.  |
| cloud_init         | UNDEF                 | Dictionary with values for Unix-like Virtual Machine initialization using cloud init. |
| cloud_init_nics    | UNDEF                 | List of dictionaries representing network interafaces to be setup by cloud init. See below for more detailed description. |
| profile            | UNDEF                 | Dictionary specifying the virtual machine hardware. See the table below.  |

The `profile` dictionary can contain following attributes:

| Name               | Default value         |                                              |
|--------------------|-----------------------|----------------------------------------------|
| cluster            | Default               | Name of the cluster where the virtual machine will be created. |
| template           | Blank                 | Name of template that the virtual machine should be based on.   |
| memory             | 2GiB                  | Amount of virtual machine memory.               |
| memory_guaranteed  | UNDEF                 | Amount of minimal guaranteed memory of the Virtual Machine. Prefix uses IEC 60027-2 standard (for example 1GiB, 1024MiB). <i>memory_guaranteed</i> parameter can't be lower than <i>memory</i> parameter. |
| cores              | 1                     | Number of CPU cores used by the the virtual machine.          |
| sockets            | UNDEF                 | Number of virtual CPUs sockets of the Virtual Machine.  |
| disks              | UNDEF                 | Dictionary specifying the additional virtual machine disks. See below for more detailed description. |
| nics               | UNDEF                 | List of dictionaries specifying the NICs of the virtual machine. See below for more detailed description.   |
| high_availability  | UNDEF                 | Whether or not the node should be set highly available. |
| storage_domain     | UNDEF                 | Name of the storage domain where all virtual machine disks should be created. Considered only when template is provided.|
| state              | running               | Should the Virtual Machine be stopped, present or running.|

Following attributes of `profile` dictionary are deprecated and will be removed in ovirt-ansible-roles version 1.1,
please use `cloud_init` parameter instead. Those parameters has precedence before `cloud_init` parameter to not
break backward compatibility, so please remove them when using `cloud_init`.

| Name               | Default value         |                                               |
|--------------------|-----------------------|-----------------------------------------------|
| ssh_key            | UNDEF                 | SSH key to be deployed to the virtual machine.|
| domain             | UNDEF                 | The domain of the virtual machine.            |
| root_password      | UNDEF                 | The root password of the virtual machine.     |

The item in `disks` list of `profile` dictionary can contain following attributes:

| Name               | Default value  |                                              |
|--------------------|----------------|----------------------------------------------| 
| size               | UNDEF          | The size of the additional disk. |
| name               | UNDEF          | The name of the additional disk.  |
| storage_domain     | UNDEF          | The name of storage domain where disk should be created. |
| interface          | UNDEF          | The interface of the disk. |
| format             | UNDEF          | Specify format of the disk.  <ul><li>cow - If set, the disk will by created as sparse disk, so space will be allocated for the volume as needed. This format is also known as thin provisioned disks</li><li>raw - If set, disk space will be allocated right away. This format is also known as preallocated disks.</li></ul> |
| bootable           | UNDEF          | True if the disk should be bootable. |

The item in `nics` list of `profile` dictionary can contain following attributes:

| Name               | Default value  |                                              |
|--------------------|----------------|----------------------------------------------| 
| name               | UNDEF          | The name of the network interface.           |
| interface          | UNDEF          | Type of the network interface.               |
| mac_address        | UNDEF          | Custom MAC address of the network interface, by default it's obtained from MAC pool. |
| network            | UNDEF          | Logical network which the VM network interface should use. If network is not specified, then Empty network is used. |
| profile            | UNDEF          | Virtual network interface profile to be attached to VM network interface. |

The item in `cloud_init` dictionary can contain all parameters documented
in upstream Ansible documentation of [ovirt_vms](http://docs.ansible.com/ansible/latest/ovirt_vms_module.html) module.

The item in `cloud_init_nics` list can contain all parameters documented
in upstream Ansible documentation of [ovirt_vms](http://docs.ansible.com/ansible/latest/ovirt_vms_module.html) module.

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
