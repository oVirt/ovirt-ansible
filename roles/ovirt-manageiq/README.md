Deploy ManageIQ in oVirt
==================================================

The `ovirt-manageiq` role downloads a ManageIQ/CloudForms QCOW image and deploys it into oVirt/Red Hat Virtualization (RHV).

The role also enables you to create a virtual machine and attach the ManageIQ disk, then wait for the ManageIQ system to initialize, and register oVirt as an infrastructure provider.

Requirements
------------

* oVirt has to be 4.0.4 or higher.
* [ovirt-imageio](http://www.ovirt.org/develop/release-management/features/storage/image-upload/) must be installed and running.
* [oVirt Python SDK version 4](https://pypi.python.org/pypi/ovirt-engine-sdk-python/4.0.4).

Additionally, perform the following checks to ensure the required processes are running.
* Check whether `ovirt-imageio-proxy` is running on the engine:
 
 ```
systemct status ovirt-imageio-proxy
```

* Check whether `ovirt-imageio-daemon` is running on the hosts:

 ```
systemct status ovirt-imageio-daemon
```

You will also require the CA certificate of the engine. To do this, configure the `ovirt_ca` variable with the path to the CA certificate.

Role Variables
--------------

QCOW variables:

| Name          | Default value                                            |  Description                                                 |
|---------------|----------------------------------------------------------|--------------------------------------------------------------|
| miq_qcow_url  | http:////releases.manageiq.org/manageiq-ovirt-fine-1.qc2 | The URL of the ManageIQ QCOW image. |
| miq_image_path | /tmp/ovirt_image_data | The path where the qcow2 image will be downloaded. |
| miq_qcow_checksum | sha256:b3644e8ac75af9663d19372e21b8a0273d68e54bfd515<br/>518321d3102d08daebd | Checksum of the qcow2 image file. It's used to validate the downloaded file.  |

Engine login variables:

| Name                | Default value     |  Description                            |
|---------------------|-------------------|-----------------------------------------|
| engine_user         | UNDEF             | The user to access the engine.          |
| engine_password     | UNDEF             | The password of the 'engine_user'.      |
| engine_fqdn         | UNDEF             | The FQDN of the engine.                 |
| engine_ca           | UNDEF             | The path to the engine's CA certificate.|

Virtual machine variables:

| Name               | Default value     |  Description                                 |
|--------------------|-------------------|----------------------------------------------|
| miq_vm_name        | manageiq_fine     | The name of the ManageIQ virtual machine. |
| miq_vm_cluster     | Default           | The cluster of the virtual machine.    |
| miq_vm_memory      | 6GiB              | The virtual machine's system memory.    |
| miq_vm_cpu         | 2                 | The number of virtual machine CPU cores.   |
| miq_vm_os          | rhel_7x64         | The virtual machine operating system. |
| miq_vm_cloud_init  | UNDEF             | The cloud init dictionary to be passed to the virtual machine. |

Virtual machine disks variables:

| Name                | Default value     |  Description                            |
|---------------------|-------------------|-----------------------------------------|
| miq_vm_disk_name    | `miq_vm_name`     | The name of the virtual machine disk.   | 
| miq_vm_disk_storage | UNDEF             | The target storage domain of the disk.  |
| miq_vm_disk_size    | 50GiB             | The virtual machine disk size.          |
| miq_vm_disk_interface | virtio          | The virtual machine disk interface type.|
| miq_vm_disk_format  | cow               | The format of the virtual machine disk. |

Virtual machine NICs variables:

| Name                | Default value     |  Description                                         |
|---------------------|-------------------|------------------------------------------------------|
| miq_vm_nics         | {'name': 'nic1', 'profile_name': 'ovirtmgmt', 'interaface': 'virtio'} | Dictionary that defines the virtual machine network interfaces. |

ManageIQ variables:

| Name          | Default value     |  Description                                         |
|---------------|-------------------|------------------------------------------------------|
| miq_username  | admin             | The username used to login to ManageIQ. |
| miq_password  | smartvm           | The password of user specific in username used to login to ManageIQ. |


RHV provider and RHV metrics variables:

| Name                  | Default value     |  Description                                         |
|-----------------------|-------------------|------------------------------------------------------|
| miq_rhv_provider_name | RHV provider      | Name of the RHV provider to be displayed in ManageIQ.|
| metrics_fqdn          | UNDEF             | FQDN of the oVirt/RHV metrics.                       |
| metrics_user          | UNDEF             | The user to connection to metrics server.            |
| metrics_password      | UNDEF             | The password of the `metrics_user` .                 |
| metrics_port          | UNDEF             | Port to connect to oVirt/RHV metrics.                |

Dependencies
------------

No.

Example Playbook
----------------

Note that for passwords you should use Ansible vault.

```yaml
    - name: Deploy ManageIQ to oVirt engine
      hosts: localhost
      gather_facts: no

      vars:
        engine_fqdn: ovirt-engine.example.com
        engine_password: 123456
        engine_username: admin@internal

        miq_vm_name: manageiq_fine
        miq_qcow_url: http://releases.manageiq.org/manageiq-ovirt-fine-1.qc2
        miq_vm_cluster: mycluster
        miq_vm_cloud_init:
          user_name: root
          root_password: securepassword

      roles:
        - ovirt-manageiq
```

License
-------

Apache License 2.0
