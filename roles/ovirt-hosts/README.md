oVirt hosts
===========

This role setup oVirt hosts.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

The item in `hosts` list can contain following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| name          | UNDEF          | Name of the host                      |
| state         | present        | State of the host                     |
| address       | UNDEF          | IP or FQDN of the host                |
| password      | UNDEF          | Root password of the host             |
| cluster       | UNDEF          | Cluster which host should connect     |
| timeout       | 1200           | Maximum wait time for host to be UP   |
| poll_interval | 20             | Polling interval to check host status |

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
    hosts:
      - name: myhost
        address: 1.2.3.4
        cluster: production
        password: 123456

  roles:
    - ovirt-hosts
```

License
-------

Apache License 2.0
