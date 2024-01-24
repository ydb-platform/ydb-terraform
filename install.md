1. ansible-galaxy collection install git+https://github.com/ydb-platform/ydb-ansible.git,refactor-use-collections
2. Забираем путь до коллекций: /home/ubuntu/.ansible/collections/ansible_collections
3. В файле ansible.cfg заменяем collections_paths на путь из строчки 2
