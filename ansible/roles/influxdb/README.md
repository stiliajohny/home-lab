Role Name
=========

This role is going to install and configure InfluxDB on a host, it will also configure this influx as a datastore on Grafana and upload a dashboard too

Requirements
------------

After the role run successfully, go to Proxmox and add a metrics server which IP is the host just provisioned with InfluxDB

Role Variables
--------------

Change the defaults on the ./defaults/main.yml
|                             |                           |
| :-------------------------- | :------------------------ |
| influxdb_udp_bind_ip_port   | 0.0.0.0:8089              |
| influxdb_database           | proxmox                   |
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
