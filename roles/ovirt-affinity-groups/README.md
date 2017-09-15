oVirt Affinity Groups
====================================

The `ovirt-affinity-groups` role is used to manage oVirt affinity groups.

Requirements
------------

 * Ansible version 2.3 or higher
 * Python SDK version 4 or higher

Role Variables
--------------

| Name               | Default value       |                                              |
|--------------------|---------------------|----------------------------------------------|
| cluster            | UNDEF (Required)    |  Name of the cluster of the affinity group.  |
| description        | UNDEF               |  Human readable description.                 |
| host_enforcing     | false               |  <ul><li>true - VM cannot start on host if it does not satisfy the `host_rule`.</li><li>false - VM will follow `host_rule` with soft enforcement.</li></ul>|
| host_rule          | UNDEF               |  <ul><li>positive - VM's in this group must run on this host.</li> <li>negative - VM's in this group may not run on this host</li></ul> |
| hosts              | UNDEF               |  List of host names assigned to this group.  |
| name               | UNDEF (Required)    |  Name of affinity group.                     |
| state              | UNDEF               |  Whether group should be present or absent.  |
| vm_enforcing       | false               |  <ul><li>true - VM cannot start if it cannot satisfy the `vm_rule`.</li><li>false - VM will follow `vm_rule` with soft enforcement.</li></ul> |
| vm_rule            | UNDEF               |  <ul><li>positive - all vms in this group try to run on the same host.</li><li>negative - all vms in this group try to run on separate hosts.</li><li>disabled - this affinity group does not take effect.</li></ul> |
| vms                | UNDEF               |  List of VM's to be assigned to this affinity group. |
| wait               | true                |  If true, the module will wait for the desired state. |

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
```
