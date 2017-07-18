oVirt Clusters
==============

The ovirt-clusters role is used set up oVirt clusters.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

| Name                  | Default value         |  Description                            |
|-----------------------|-----------------------|-----------------------------------------|
| clusters              | UNDEF                 | List of dictionaries that describe the cluster. |
| data_center_name      | UNDEF                 | Name of the data center.                 |
| compatibility_version | UNDEF                 | Compatibility version of data center.    |

The `clusters` list can contain the following parameters:

| Name                              | Default value       | Description                             |
|-----------------------------------|---------------------|-----------------------------------------|
| name                              | UNDEF               | Name of the cluster.                     |
| state                             | present             | State of the cluster.                    |
| cpu_type                          | Intel Conroe Family | CPU type of the cluster.                 |
| profile                           | UNDEF               | The cluster profile. You can choose a predefined cluster profile, see the tables below. |
| ballooning                        | UNDEF               | If True, enables memory balloon optimization. |
| description                       | UNDEF               | Description of the cluster. |
| ksm                               | UNDEF               | If True, enables Kernel Same-page Merging (KSM). |
| ksm_numa                          | UNDEF               | If True, enables KSM for the best performance inside NUMA nodes. |
| vm_reason                         | UNDEF               | If True, enables an optional reason field when a virtual machine is shut down. |
| host_reason                       | UNDEF               | If True, enables an optional reason field when a host is placed into maintenance. |
| memory_policy                     | UNDEF               | The memory policy used by the cluster. |
| migration_policy                  | UNDEF               | The migration policy used by the cluster. |
| scheduling_policy                 | UNDEF               | The scheduling policy used by the cluster. |
| ha_reservation                    | UNDEF               | If True, monitors the cluster capacity for highly available virtual machines. |
| fence_enabled                     | UNDEF               | If True, enables fencing on the cluster. |
| fence_skip_if_connectivity_broken | UNDEF               | If True, fencing will be temporarily disabled if the percentage of hosts in the cluster that are experiencing connectivity issues is greater than or equal to the defined threshold. |
| fence_skip_if_sd_active           | UNDEF               | If True, any hosts in the cluster that are Non Responsive and still connected to storage will not be fenced. |

More information about the parameters can be found in the [Ansible documentation](http://docs.ansible.com/ansible/ovirt_clusters_module.html).

Possible `profile` options are `development` and `production`, their default values are described below:

`Development`:

| Parameter        | Value         |
|------------------|---------------|
| ballooning       | true          |
| ksm              | true          |
| host_reason      | false         |
| vm_reason        | false         |
| memory_policy    | server        |
| migration_policy | post_copy     |

`Production`:

| Parameter                         | Value              |
|-----------------------------------|--------------------|
| ballooning                        | false              |
| ksm                               | false              |
| host_reason                       | true               |
| vm_reason                         | true               |
| memory_policy                     | disabled           |
| migration_policy                  | suspend_workload   |
| scheduling_policy                 | evenly_distributed |
| ha_reservation                    | true               |
| fence_enabled                     | true               |
| fence_skip_if_connectivity_broken | true               |
| fence_skip_if_sd_active           | true               |

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

   clusters:
     - name: production
       cpu_type: Intel Conroe Family
       profile: production

  roles:
    - ovirt-clusters
```

License
-------

Apache License 2.0
