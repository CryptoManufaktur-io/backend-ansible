# Backend-ansible

Ansible scripts for linux hosts.

## Run Playbook

1. Update inventory file located at `backend-ansible/production/inventory.yml` as required

2. Copy `backend-ansible/production/group_vars/sample.yml` variables file to `backend-ansible/production/group_vars/main.yml`

3. Replace the variables as required in file copied `backend-ansible/production/group_vars/main.yml`

4. Run ansible playbook with command

      ```shell
      ansible-playbook -i production/inventory.yml chainlink.yml
      ```

### Extra vars

Some playbooks like the `bastion_ssh_only` require your Infra Bastion username, which should be set via extra vars. E.g:

```shell
ansible-playbook -i /path/to/inventory --extra-vars "bastion_username=jdoe" bastion_ssh_only.yml
```
