oVirt permissions
=================

This role setup oVirt permissions.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

The item in `permissions` list can contain following parameters:

| Name          | Default value  | Description                |
|---------------|----------------|----------------------------|
| state         | present        | State of the permission    |
| user_name     | UNDEF          | User name of user to manage permission |
| group_name    | UNDEF          | Name of group to manage permission |
| authz_name    | UNDEF          | Name of the authorization provider of the group or user |
| role          | UNDEF          | Role to be assigned to user or group |
| object_type   | UNDEF          | The object type which should be used to assign permission |
| object_name   | UNDEF          | Name of the object where permission should be assigned |

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
    permissions:
      - state: present
        user_name: user1
        authz_name: internal-authz
        role: UserRole
        object_type: cluster
        object_name: production
   
      - state: present
        group_name: group1
        authz_name: internal-authz
        role: UserRole
        object_type: cluster
        object_name: production

  roles:
    - ovirt-permissions
```

License
-------

Apache License 2.0 License 2.0
