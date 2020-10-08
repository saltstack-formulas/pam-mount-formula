# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import pam__mount with context %}

pam-mount-service-clean-service-dead:
  service.dead:
    - name: {{ pam__mount.service.name }}
    - enable: False
