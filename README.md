# Backend-ansible

Ansible scripts for linux hosts.

## Run Playbook

1. Copy `production/inventory.sample.yml` to `production/inventory.yml` and modify as necessary.

2. Copy `production/group_vars/all.sample.yml` variables file to `production/group_vars/all.yml` and update as necessary.

3. Replace the variables as required in file copied `backend-ansible/production/group_vars/main.yml`

4. Run ansible playbook:

      ```shell
      ansible-playbook -i production/inventory.yml site.yml
      ```

## Playbooks

- `site.yml`: Sets up all new servers with bastion host SSH access only and basic software like Docker, etc.
- `node.yml`: Deploys RPC nodes using [eth-docker](https://github.com/eth-educators/eth-docker).

### Targeting specific hosts

The `--limit` argument allows you to target a specific host from the inventory.

```shell
ansible-playbook -i production/inventory.yml --limit=mytarget.example.com site.yml
```

If you want to check what hosts have been selected by the filter, you can add the `--list-hosts` argument.

```shell
ansible-playbook -i production/inventory.yml --limit=mytarget.example.com --list-hosts site.yml
```
