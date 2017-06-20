oVirt cluster upgrade
=========

This role will iterate through all hosts in cluster and upgrades them.

Requirements
------------

 * Ansible version 2.3 or higher
 * Python SDK version 4 or higher

Role Variables
--------------

| Name                    | Default value         |                                                     |
|-------------------------|-----------------------|-----------------------------------------------------|
| cluster_name            | Default               | Name of the cluster to be upgraded.                 |
| stopped_vms             | UNDEF                 | List of VM names to be stopped before upgrade.      |
| stop_pinned_to_host_vms | false                 | If true the pinned to host VMs will be stopped.     |
| upgrade_timeout         | 1200                  | Timeout in seconds to wait for host to be upgraded. |
| host_statuses           | [UP]                  | If the hosts are in any of the statuses specified by this list, the host will be upgraded. |
| host_names              | [\*]                  | List of host names which should be upgraded.        |

Dependencies
------------

No.

Example Playbook
----------------

```yaml
---
- name: oVirt infra
  hosts: localhost
  connection: local
  gather_facts: false

  vars:
    engine_url: https://ovirt-engine.example.com/ovirt-engine/api
    engine_user: admin@internal
    engine_password: 123456
    engine_cafile: /etc/pki/ovirt-engine/ca.pem

    cluster_name: production
    stopped_vms:
      - openshift-master-0
      - openshift-node-0
      - openshift-node-image

  roles:
    - ovirt-cluster-upgrade
```

[![asciicast](https://asciinema.org/a/122760.png)](https://asciinema.org/a/122760)

License
-------

Apache License 2.0
