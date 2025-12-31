# Ansible

run the config

```bash
ansible-playbook -i inventory.ini main.yaml
```

Sometimes, the geoserver download link times out. in that case, run

```bash
ansible-playbook -i inventory.ini main.yaml --tags geoserver
```