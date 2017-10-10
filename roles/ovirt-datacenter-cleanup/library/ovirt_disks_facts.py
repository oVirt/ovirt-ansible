#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Copyright (c) 2017 Red Hat, Inc.


ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}


DOCUMENTATION = '''
---
module: ovirt_disks_facts
short_description: Retrieve facts about one or more oVirt/RHV disks
author: "Katerina Koukiou (@kkoukiou)"
version_added: "2.5"
description:
    - "Retrieve facts about one or more oVirt/RHV disks."
notes:
    - "This module creates a new top-level C(ovirt_disks) fact, which
       contains a list of disks."
options:
    pattern:
      description:
        - "Search term which is accepted by oVirt/RHV search backend."
        - "For example to search Disk X from storafe Y use following pattern:
           name=X and storage.name=Y"
extends_documentation_fragment: ovirt_facts
'''

EXAMPLES = '''
# Examples don't contain auth parameter for simplicity,
# look at ovirt_auth module to see how to reuse authentication:
# Gather facts about all Disks which names start with C(centos)
- ovirt_disks_facts:
    pattern: name=centos*
- debug:
    var: ovirt_disks
'''

RETURN = '''
ovirt_disks:
    description: "List of dictionaries describing the Disks. Disk attributes are mapped to dictionary keys,
                  all Disks attributes can be found at following url: http://ovirt.github.io/ovirt-engine-api-model/master/#types/disk."
    returned: On success.
    type: list
'''

import traceback

from ansible.module_utils.basic import AnsibleModule
from ansible.module_utils.ovirt import (
    check_sdk,
    create_connection,
    get_dict_of_struct,
    ovirt_facts_full_argument_spec,
)


def main():
    argument_spec = ovirt_facts_full_argument_spec(
        pattern=dict(default='', required=False),
    )
    module = AnsibleModule(argument_spec)
    check_sdk(module)

    try:
        auth = module.params.pop('auth')
        connection = create_connection(auth)
        disks_service = connection.system_service().disks_service()
        disks = disks_service.list(
            search=module.params['pattern'],
        )
        module.exit_json(
            changed=False,
            ansible_facts=dict(
                ovirt_disks=[
                    get_dict_of_struct(
                        struct=c,
                        connection=connection,
                        fetch_nested=module.params.get('fetch_nested'),
                        attributes=module.params.get('nested_attributes'),
                    ) for c in disks
                ],
            ),
        )
    except Exception as e:
        module.fail_json(msg=str(e), exception=traceback.format_exc())
    finally:
        connection.close(logout=auth.get('token') is None)


if __name__ == '__main__':
    main()
