oVirt Networks
==============

The `ovirt-networks` role sets up oVirt networks.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

The `data_center_name` variable specifes the data center name of the network.

The `logical_networks` list can contain following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| name          | UNDEF          | Name of the network.                   |
| state         | present        | Specifies whether the network state is `present` or `absent`. |
| vlan_tag      | UNDEF          | IP address or FQDN of the host.                |
| vm_network    | UNDEF          | Root password of the host.             |
| mtu           | UNDEF          | Cluster which host should connect to.     |
| description   | 1200           | Maximum wait time for host to be in an UP state.  |
| clusters      | 20             | Polling interval to check the host status. |

More information about logical networks can be found [here](http://docs.ansible.com/ansible/ovirt_networks_module.html).

The `host_networks` list can contain following parameters:

| Name          | Default value  | Description                           |
|---------------|----------------|---------------------------------------|
| name          | UNDEF          | Name of the host.                      |
| state         | UNDEF          | Specifies whether the network state is `present` or `absent`.            |
| check         | UNDEF          | If true, verifies the connection between the host and engine. |
| save          | UNDEF          | If true, the network configuration will be persistent, by default it is temporary. |
| bond          | UNDEF          | Dictionary describing the network bond. |
| networks      | UNDEF          | Dictionary describing the networks to be attached to the interface or bond. |
| labels        | UNDEF          | List of names of the network label to be assigned to the bond or interface. |
| interface     | UNDEF          | Name of the network interface where the logical network should be attached. |

More information about host networks can be found [here](http://docs.ansible.com/ansible/ovirt_host_networks_module.html).

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
   logical_networks:
     - name: mynetwork
       clusters:
         - name: development
           assigned: yes
           required: no
           display: no
           migration: yes
           gluster: no

   host_networks:
     - name: myhost1
       check: true
       save: true
       bond:
         name: bond0
         mode: 2
         interfaces:
           - eth2
           - eth3
       networks:
         - name: mynetwork
           boot_protocol: dhcp

  roles:
    - ovirt-networks
```

License
-------

Apache License 2.0
