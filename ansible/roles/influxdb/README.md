Role Name
=========

A brief description of the role goes here.

Requirements
------------

N/A

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
    - influxdb
```

License
-------

GPL3

Author Information
------------------

John Stilia
