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
| ssh_key            | UNDEF                 | SSH key to be deployed to the virtual machine.                 |
| domain             | UNDEF                 | The domain of the virtual machine.                         |
| root_password      | UNDEF                 | The root password of the virtual machine.                      |
| cloud_init_nics    | UNDEF                 | List of dictionaries representing network interafaces to be setup by cloud init. See below for more detailed description. |
| high_availability  | UNDEF                 | Whether or not the node should be set highly available. |
| storage_domain     | UNDEF                 | Name of the storage domain where all virtual machine disks should be created. Considered only when template is provided.|
| state              | present               | Should the Virtual Machine be stopped, present or running.|

The item in `disks` list of `profile` dictionary can contain following attributes:

| Name               | Default value  |                                              |
|--------------------|----------------|----------------------------------------------| 
| size               | UNDEF          | The size of the additional disk. |
| name               | UNDEF          | The name of the additional disk.  |
| storage_domain     | UNDEF          | The name of storage domain where disk should be created. |
| interface          | UNDEF          | The interface of the disk. |

The item in `nics` list of `profile` dictionary can contain following attributes:

| Name           | Default value  |                                              |
|----------------|----------------|----------------------------------------------| 
| name           | UNDEF          | Name of the NIC. |
| profile_name   | UNDEF          | Profile name where NIC should be attached. |
| interface      | UNDEF          | Type of the network interface. One of following: virtio, e1000, rtl8139, default is virtio. |
| mac_address    | UNDEF          | Custom MAC address of the network interface, by default it's obtained from MAC pool. |
| network        | UNDEF          | Logical network to which the VM network interface should use, by default Empty network is used if network is not specified. |

The item in `cloud_init_nics` list of `profile` dictionary can contain following attributes:

| Name               | Default value  |                                              |
|--------------------|----------------|----------------------------------------------| 
| nic_boot_protocol  | UNDEF          | Set boot protocol of the network interface of Virtual Machine. Can be one of none, dhcp or static. |
| nic_ip_address     | UNDEF          | If boot protocol is static, set this IP address to network interface of Virtual Machine.
| nic_netmask        | UNDEF          | If boot protocol is static, set this netmask to network interface of Virtual Machine.
| nic_gateway        | UNDEF          | If boot protocol is static, set this gateway to network interface of Virtual Machine.
| nic_name           | UNDEF          | Set name to network interface of Virtual Machine.
| nic_on_boot        | UNDEF          | If True network interface will be set to start on boot.

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
