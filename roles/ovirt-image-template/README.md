oVirt Image Template
====================

The `ovirt-image-template` role downloads a QCOW2 image from a specified URL and creates a template from it.

Requirements
------------

 * Ansible version 2.3 or higher.
 * Python SDK version 4 or higher.
 * oVirt has to be 4.0.4 or higher and [ovirt-imageio] must be installed and running.
 * CA certificate of oVirt engine. The path to CA certificate must be specified in the `ovirt_ca` variable.

Role Variables
--------------

| Name               | Default value         |                            |
|--------------------|-----------------------|----------------------------| 
| qcow_url           | UNDEF                 | The URL of the QCOW2 image. |
| image_path         | /tmp/ovirt_image_data | Path where the QCOW2 image will be downloaded to. |
| template_cluster   | Default               | Name of the cluster where template must be created. |
| template_name      | mytemplate            | Name of the template. |
| template_memory    | 2GiB                  | Amount of memory assigned to the template. |
| template_cpu       | 1                     | Number of CPUs assigned to the template.  |
| template_disk_storage | UNDEF              | Name of the data storage domain where the disk must be created. If not specified, the data storage domain is selected automatically. |
| template_disk_size | 10GiB                 | The size of the template disk.  |
| template_disk_format | cow                 | Format of the template disk.  |
| template_disk_interface | virtio           | Interface of the template disk. |
| template_timeout   | 600                   | Amount of time to wait for the template to be created. |
| template_nics      | {name: nic1, profile_name: ovirtmgmt, interface: virtio} | List of dictionaries that specify the NICs of template. |

Dependencies
------------

No.

Example Playbook
----------------

```yaml
---
- name: oVirt image template
  hosts: localhost
  connection: local
  gather_facts: false

  vars:
    engine_url: https://ovirt-engine.example.com/ovirt-engine/api
    engine_user: admin@internal
    engine_password: 123456
    engine_cafile: /etc/pki/ovirt-engine/ca.pem

    qcow_url: https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2
    template_cluster: production
    template_name: centos7_template
    template_memory: 4GiB
    template_cpu: 2
    template_disk_size: 10GiB
    template_disk_storage: mydata

  roles:
    - ovirt-image-template
```

[![asciicast](https://asciinema.org/a/111478.png)](https://asciinema.org/a/111478)

License
-------

Apache License 2.0

[ovirt-imageio]: http://www.ovirt.org/develop/release-management/features/storage/image-upload/
