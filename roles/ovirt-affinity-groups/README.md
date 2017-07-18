oVirt affinity groups
====================================

This role manages affinity groups in oVirt.

Requirements
------------

 * Ansible version 2.3 or higher
 * Python SDK version 4 or higher

Role Variables
--------------

| Name               | Default value       |                                              |
|--------------------|---------------------|----------------------------------------------|
| cluster            | UNDEF               |  Name of the cluster of the affinity group.  |
| description        | UNDEF               |  Human readable description.                 |
| host_enforcing     | false               |  If true VM cannot start on host if it does not satisfy the host_rule.|
| host_rule          | UNDEF               |  positive: VM's in this group must run on this host. negative: VM's in this group may not run on this host |
| hosts              | UNDEF               |  List of host names assigned to this group.  |
| name               | UNDEF (Required)    |  Name of affinity group.                     |
| state              | UNDEF               |  Whether group should be present or absent.  |
| vm_enforcing       | false               |  If true, VM cannot start if it cannot satisfy the vm_rule. |
| vm_rule            | UNDEF               |  positive: all vms in this group try to run on the same host. negative: all vms in this group try to run on separate hosts. disabled: this affinity group does not take effect. |
| vms                | UNDEF               |  List of VM's to be assigned to this affinity group. |
| wait               | false               |  If true, the module should wait for the desired state. |

Dependencies
------------

No.

Example Playbook
----------------
```yaml
---
- name: oVirt affinity groups
  hosts: localhost
  connection: local
  gather_facts: false

  vars:
    affinity_groups:
      - name: web_ag
        cluster: production
        vm_enforcing: false
        vm_rule: negative
        vms:
          - httpd_vm
          - postgresql-vm
