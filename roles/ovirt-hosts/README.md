oVirt Hosts
===========

The `ovirt-hosts` role is used to set up oVirt hosts.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

The `hosts` list can contain the following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| name          | UNDEF          | Name of the host.                      |
| state         | present        | Specifies whether the host is `present` or `absent`.  |
| address       | UNDEF          | IP address or FQDN of the host.   |
| password      | UNDEF          | The host's root password.             |
| cluster       | UNDEF          | The cluster that the host must connect to.    |
| timeout       | 1200           | Maximum wait time for the host to be in an UP state.  |
| poll_interval | 20             | Polling interval to check the host status. |

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
