New modules
===========

Here is the list of newly added modules by this role:

1. ovirt_api_facts.py

- Contains a new module to retrieve facts from oVirt api: [PR](https://github.com/ansible/ansible/pull/28875).
  The module will be available in Ansible 2.5.

2. ovirt_scheduling_policies_facts.py

- Contains new module for retrieving facts from scheduling policies: [PR](https://github.com/ansible/ansible/pull/25055).
  The module will be available in Ansible 2.4.

Bug fixes
=========

Here is the list of bug fixes provided by this role:

1. ovirt_hosts.py

 - Contains a bug fix to cover upgrade proccess of host in maintanance state: [PR](https://github.com/ansible/ansible/pull/25169).
   The fix will be available in Ansible 2.3.2.

 - Contains a feature to check for upgrade before sending upgrade action: [PR](https://github.com/ansible/ansible/pull/28437).
   The fix will be available in Ansible 2.4.

2. ovirt_clusters.py

 - Contains a bug fix to check the scheduling policy of cluster [PR](https://github.com/ansible/ansible/pull/23452/).
   The fix will be available in Ansible 2.4.
