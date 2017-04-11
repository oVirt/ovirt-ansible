oVirt AAA JDBC
==============

This role manages users and groups in AAA JDBC extension.

Requirements
------------

 * Ansible version 2.2

Role Variables
--------------

The item in `users` list can contain following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| state         | present        | Whether the user should be present or absent |
| name          | UNDEF          | Name of the user                      |
| authz_name    | UNDEF          | Authorization provider of the user    |
| password      | UNDEF          | Password of the user                  |
| valid_to      | UNDEF          | The date until the account should be valid |

The item in `user_groups` list can contain following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| state         | present        | Whether the group should be present or absent |
| name          | UNDEF          | Name of the group                     |
| authz_name    | UNDEF          | Authorization provider of the group   |
| users         | UNDEF          | List of user names which should be part of this group |

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
    users:
     - name: user1
       authz_name: internal-authz
       password: 1234568
       valid_to: "2018-01-01 00:00:00Z"
     - name: user2
       authz_name: internal-authz
       password: 1234568
       valid_to: "2018-01-01 00:00:00Z"
    
    user_groups:
     - name: group1
       authz_name: internal-authz
       users:
        - user1

  roles:
    - ovirt-aaa-jdbc
```

License
-------

Apache License 2.0
