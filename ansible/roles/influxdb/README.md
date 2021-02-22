Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

Change the defaults on the ./defaults/main.yml
|                             |                           |
| :--------------------------- | :------------------------- |
| http_bind_ip_port           | 0.0.0.0:8888              |
| udp_bind_ip_port            | 0.0.0.0:8089              |
| database                    | proxmox                   |
| provision_grafana_dashboard | true                      |
| grafana_endpoint            | http://192.168.1.113:3000 |
| grafana_user                | admin                     |
| grafana_password            | admin                     |

Dependencies
------------

N/A

Example Playbook
----------------
```yaml
---
- hosts: all
  gather_facts: yes
  become: true
  roles:
#    - server_banners_prompts
    - influxdb
```

License
-------

GPL3

Author Information
------------------

John Stilia