oVirt clusters
==============

This role setup oVirt clusters.

Requirements
------------

 * oVirt Python SDK version 4
 * Ansible version 2.3

Role Variables
--------------

| Name                  | Default value         |  Description                            |
|-----------------------|-----------------------|-----------------------------------------|
| clusters              | UNDEF                 | List of dictionaries describing cluster |
| data_center_name      | UNDEF                 | Name of the data center                 |
| compatibility_version | UNDEF                 | Compatibility version of data center    |

The item in `clusters` list can contain following parameters:

| Name                              | Default value       | Description                             |
|-----------------------------------|---------------------|-----------------------------------------|
| name                              | UNDEF               | Name of the cluster                     |
| state                             | present             | State of the cluster                    |
| cpu_type                          | Intel Conroe Family | CPU type of the cluster                 |
| profile                           | UNDEF               | Cluster profile. You can choose predefined cluster profile, see below |
| ballooning                        | UNDEF               | Enable memory balloon optimization |
| description                       | UNDEF               | Description of the cluster |
| ksm                               | UNDEF               | Enables to run Kernel Same-page Merging |
| ksm_numa                          | UNDEF               | Enables KSM for best berformance inside NUMA nodes |
| vm_reason                         | UNDEF               | Enable an optional reason field when a virtual machine is shut down |
| host_reason                       | UNDEF               | Enable an optional reason field when a host is placed into maintenance |
| memory_policy                     | UNDEF               | Memory policy of the cluster |
| migration_policy                  | UNDEF               | Migration policy of the cluster |
| scheduling_policy                 | UNDEF               | Scheduling policy of the cluster |
| ha_reservation                    | UNDEF               | Enable monitoring of cluster capacity for highly available virtual machines |
| fence_enabled                     | UNDEF               | Enables fencing on the cluster |
| fence_skip_if_connectivity_broken | UNDEF               | If True fencing will be temporarily disabled if the percentage of hosts in the cluster that are experiencing connectivity issues is greater than or equal to the defined threshold |
| fence_skip_if_sd_active           | UNDEF               | If True any hosts in the cluster that are Non Responsive and still connected to storage will not be fenced |

More information about the parameters can be found [here](http://docs.ansible.com/ansible/ovirt_clusters_module.html).

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
