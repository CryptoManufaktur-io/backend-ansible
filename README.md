# Backend-ansible

Ansible scripts for baremetal backend running chain nodes

## Run Playbook

1. Update inventory file located at `backend-ansible/chainlink/inventory/main.yml` as required

2. Copy `backend-ansible/chainlink/vars/sample.yml` variables file to `backend-ansible/chainlink/vars/main.yml`

3. Replace the variables as required in file copied `backend-ansible/chainlink/vars/main.yml`

4. Run ansible playbook with command

      ```text
      ansible-playbook -i inventory/main.yml main.yml
      ```
