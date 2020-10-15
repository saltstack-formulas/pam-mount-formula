# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as pam_mount with context %}

include:
  - {{ sls_config_clean }}

{%- set package = pam_mount | traverse("pkg:name") %}
{%- set dependencies = pam_mount | traverse("pkg:dependencies", []) %}

pam_mount/package/clean/dependencies/pkg.purged:
  pkg.purged:
    - pkgs: {{ dependencies | json }}
    - require:
      - sls: {{ sls_config_clean }}

pam-mount/package/clean/{{ package }}/pkg.purged:
  pkg.purged:
    - name: {{ package }}
    - require:
      - sls: {{ sls_config_clean }}
