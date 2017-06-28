ManageIQ/CloudForms deployment on top of oVirt/RHV
==================================================

This role downloads ManageIQ/CloudForms qcow image and deploys it into oVirt/RHV.
Create a virtual machine and attach the ManageIQ/CloudForms disk. Then wait for
initialization of the ManageIQ/CloudForms system and register the RHV/oVirt as
a infrastructure provider.

Requirements
------------

oVirt has to be 4.0.4 or higher and [ovirt-imageio](http://www.ovirt.org/develop/release-management/features/storage/image-upload/) must be installed and running.
The target machine has to have installed [Python SDK](https://pypi.python.org/pypi/ovirt-engine-sdk-python/4.0.4).

Check `ovirt-imageio-proxy` is running on engine:

```
systemct status ovirt-imageio-proxy
```

Also check if `ovirt-imageio-daemon` is running on hosts:

```
systemct status ovirt-imageio-daemon
```

You also have to use your CA certificate of the engine.
You must configure the `ovirt_ca` varible with the path to the CA.

Role Variables
--------------

QCOW varibles:

| Name          | Default value                                            |  Description                                                 |
|---------------|----------------------------------------------------------|--------------------------------------------------------------|
| miq_qcow_url  | http:////releases.manageiq.org/manageiq-ovirt-fine-1.qc2 | Define the URL where the ManageIQ/CloudForms qcow is stored. |

oVirt/RHV engine login variables:

| Name                | Default value     |  Description                                    |
|---------------------|-------------------|-------------------------------------------------|
| engine_user         | UNDEF             | Define the user to be used to access oVirt/RHV. |
| engine_password     | UNDEF             | Define password of the 'ovirt_user'.            |
| engine_fqdn         | UNDEF             | Define the FQDN of the oVirt/RHV.               |
| engine_ca           | UNDEF             | Define the path to the CA of the oVirt/RHV.     |

Virtual Machine variables:

| Name               | Default value     |  Description                                 |
|--------------------|-------------------|----------------------------------------------|
| miq_vm_name        | manageiq_fine     | Define the name of the ManageIQ/CloudForms VM in oVirt/RHV. |
| miq_vm_cluster     | Default           | Define the cluster of the virtual machine.    |
| miq_vm_memory      | 6GiB              | Define the system memory of the virtual machine.    |
| miq_vm_cpu         | 2                 | Define the number of virtual machine CPU cores.   |
| miq_vm_os          | rhel_7x64         | Define the operating system of the virtual machine. |
| miq_vm_cloud_init  | UNDEF             | Define cloud init dictionary to be passed to virtual machine. |

Virtual Machine disks variables:

| Name                | Default value     |  Description                                         |
|---------------------|-------------------|------------------------------------------------------|
| miq_vm_disk_name    | `miq_vm_name`     | Define name of the virtual machine disk.             | 
| miq_vm_disk_storage | UNDEF             | Define the target storage domain of the disk.        |
| miq_vm_disk_size    | 50GiB             | Define the size of the virtual machine disk.         |
| miq_vm_disk_interface | virtio          | Define the interface of the virtual machine disk.    |
| miq_vm_disk_format  | cow               | Define the format of the virtual machine disk.       |

Virtual Machine nics variables:

| Name                | Default value     |  Description                                         |
|---------------------|-------------------|------------------------------------------------------|
| miq_vm_nics         | {'name': 'nic1', 'profile_name': 'ovirtmgmt', 'interaface': 'virtio'} | Dictionary variable which define network interfaces for virtual machine. |

RHV provider variables:

| Name                  | Default value     |  Description                                         |
|-----------------------|-------------------|------------------------------------------------------|
| miq_rhv_provider_name | RHV provider      | Name of the RHV provider to be displayed in ManageIQ.|
| metrics_user          | UNDEF             | The username of the user used to connection to metrics server.  |
| metrics_password      | UNDEF             | The password of the `metrics_user` .                 |

Dependencies
------------

No.

Example Playbook
----------------

Note that for passwords you should be using Ansible vault.

```yaml
    - name: Deploy ManageIQ to oVirt engine
      hosts: localhost
      gather_facts: no

      vars:
        ovirt_fqdn: ovirt-engine.example.com
        ovirt_password: 123456
        ovirt_username: admin@internal

        miq_vm_name: manageiq_fine
        miq_qcow_url: http://releases.manageiq.org/manageiq-ovirt-fine-1.qc2
        miq_vm_cluster: mycluster
        miq_vm_cloud_init:
          user_name: root
          root_password: securepassword

      roles:
        - ovirt.ovirt-manageiq
```

License
-------

Apache License 2.0
