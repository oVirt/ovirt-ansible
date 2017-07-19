oVirt Datacenters
=================

The `ovirt-datacenters` role is used to set up oVirt datacenters.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

| Name                     | Default value         | Description                          |
|--------------------------|-----------------------|--------------------------------------|
| data_center_name         | UNDEF                 | Name of the data center.              |
| data_center_description  | UNDEF                 | Description of the data center.       |
| data_center_local        | false                 | Specify whether the data center is shared or local. |
| compatibility_version    | UNDEF                 | Compatibility version of data center. |

Dependencies
------------

No.

Example Playbook
----------------

```yaml
- name: oVirt infra
  hosts: localhost
  connection: local
  gather_facts: false

  vars:
   data_center_name: mydatacenter
   data_center_description: mydatacenter
   data_center_local: false
   compatibility_version: 4.1

  roles:
    - ovirt-datacenters
```

License
-------

Apache License 2.0
