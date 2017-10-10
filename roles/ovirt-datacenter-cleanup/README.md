oVirt Datacenter Cleanup
========================

The `ovirt-datacenter-cleanup` role is used to cleanup all entities inside
oVirt datacenters and finally remove the datacenters themselves.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

| Name                     | Default value         | Description                          |
|--------------------------|-----------------------|--------------------------------------|
| data_center_name         | UNDEF                 | Name of the data center.             |
| format_storages          | false                 | Whether role should format storages when removing them. |

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
   format_storages: true

  roles:
    - ovirt-datacenter-cleanup
```

License
-------

Apache License 2.0
