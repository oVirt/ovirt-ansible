oVirt AAA JDBC
==============

The `ovirt-aaa-jdbc` role manages users and groups in an AAA JDBC extension.

Requirements
------------

 * Ansible version 2.2

Role Variables
--------------

The items in `users` list can contain the following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| state         | present        | Specifies whether the user is `present` or `absent`. |
| name          | UNDEF          | Name of the user.                      |
| authz_name    | UNDEF          | Authorization provider of the user.    |
| password      | UNDEF          | Password of the user.                  |
| valid_to      | UNDEF          | Specifies the date that the account remains valid. |

The items in `user_groups` list can contain the following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| state         | present        | Specifies whether the group is `present` or `absent`. |
| name          | UNDEF          | Name of the group.                     |
| authz_name    | UNDEF          | Authorization provider of the group.   |
| users         | UNDEF          | List of users that belong to this group. |

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
