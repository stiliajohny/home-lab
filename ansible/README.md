Ansible roles for setting up various VMs in the lab

To run ansible against the hosts run:
`ansible all -i 192.168.1.51, -m include_role -a name=influxdb -u root -K -k`