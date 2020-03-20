# HW-10 Ansible

## HW Task

Подготовить стенд на Vagrant как минимум с одним сервером. На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:
    - необходимо использовать модуль yum/apt
    - конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными
    - после установки nginx должен быть в режиме enabled в systemd
    - должен быть использован notify для старта nginx после установки
    - сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible
* Сделать все это с использованием Ansible роли

## Process of HW

1. Creating nginx role for ansible.
   1. Create template with `ansible-galaxy init nginx` at `roles`.
   2. Write my own playbooks `./roles/nginx/tasks` for installing & configuring nginx.
   3. Create jinja2 templates at `./roles/nginx/templates`.
   4. Create handlers at `./roles/nginx/handlers`.
2. Using vars.

## Results & how to check

1. Run `vagrant up`.
2. Check that vm started on 2222 port. Fix `ansible_port` at `./environments/prod/inventory.yml` if need.
3. Run `ansible-playbook playbooks/nginx.yml`.
4. Check with `curl 127.0.0.1:8080` or at browser.
