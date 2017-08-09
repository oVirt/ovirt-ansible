oVirt External Providers
========================

The `ovirt-external-providers` role is used set up oVirt external providers.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

| Name                  | Default value         |  Description                                              |
|-----------------------|-----------------------|-----------------------------------------------------------|
| external_providers    | UNDEF                 | List of dictionaries that describe the external provider. |

The `external_providers` list can contain the following parameters:

| Name                   | Default value       | Description                                                                      |
|------------------------|---------------------|----------------------------------------------------------------------------------|
| name                   | UNDEF               | Name of the external provider.                                                   |
| state                  | present             | State of the external provider.                                                  |
| type                   | UNDEF               | Type of the external provider. Values can be: <ul><li>os_image</li><li>network</li><li>os_volume</li><li>foreman</li></ul>|
| url                     | UNDEF               | URL where external provider is hosted.                                          |
| username                | UNDEF               | Username to be used for login to external provider. Applicable for all types.   |
| password                | UNDEF               | Password of the user specified in username parameter. Applicable for all types. |
| tenant                  | UNDEF               | Name of the tenant. |
| auth_url                | UNDEF               | Keystone authentication URL of the openstack provider. required: <ul><li>os_image</li><li>network</li><li>os_volume</li></ul>|

More information about the parameters can be found in the [Ansible documentation](http://docs.ansible.com/ansible/latest/ovirt_external_providers_module.html).


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

   external_providers:
     - name: myglance
       type: os_image
       state: present
       url: http://externalprovider.example.com:9292
       username: admin
       password: secret
       tenant: admin
       auth_url: http://externalprovider.example.com:35357/v2.0/
     - name: public-glance
       type: os_image
       state: present
       url: http://glance.public.com:9292

  roles:
    - ovirt-external-providers
```

License
-------

Apache License 2.0
