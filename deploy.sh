#!/usr/bin/env bash
ansible-playbook -vv --diff -K playbook.yaml $@
