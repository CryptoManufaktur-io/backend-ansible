# Backend-ansible

Ansible scripts for Linux hosts running Eth Docker patterned repos in Docker

## Run Playbook

1. Copy `production/inventory.sample.yml` to `production/inventory.yml` and modify as necessary.

2. Copy `production/group_vars/all.sample.yml` variables file to `production/group_vars/all.yml` and update as necessary.

3. Replace the variables as required in file copied `backend-ansible/production/group_vars/main.yml`

4. Run ansible playbook:

      ```shell
      ansible-playbook -i production/inventory.yml deploy.yml
      ```

## Playbooks

- `deploy.yml`: Set up a new server, optionally with repos like traefik and Eth Docker
- `update.yml`: Update all repos on a server, or a specific repo by name by passing -e "repo=myrepo"
- `bookworm.yml`: Update a Debian 11 "bullseye" server to Debian 12 "bookworm" 

Older playbooks that will be sunset:
- `site.yml`: Sets up all new servers with bastion host SSH access only and basic software like Docker, etc.
- `node.yml`: Deploys RPC nodes using [eth-docker](https://github.com/eth-educators/eth-docker).

### Targeting specific hosts

The `--limit` argument allows you to target a specific host from the inventory.

```shell
ansible-playbook -i production/inventory.yml --limit=mytarget.example.com deploy.yml
```

If you want to check what hosts have been selected by the filter, you can add the `--list-hosts` argument.

```shell
ansible-playbook -i production/inventory.yml --limit=mytarget.example.com --list-hosts deploy.yml
```

### NMS
To send metrics to NMS, a config is added to prometheus and loki. Check on `roles/base/custom_prometheus_loki` for the implementation and templates of config updates.

This can be used to send metrics and logs to any other server as needed by changing the URLs in `all.yml` specifically below

```yml
nms_metrics_url:  URL
nms_logs_url:     URL
nms_username:     USERNAME
nms_password:     PASSWORD
nms_operator:     CryptoManufaktur
```
