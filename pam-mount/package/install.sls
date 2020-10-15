# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as pam_mount with context %}

{%- set package = pam_mount | traverse("pkg:name") %}
{%- set dependencies = pam_mount | traverse("pkg:dependencies", []) %}

pam_mount/package/install/dependencies/pkg.installed:
  pkg.installed:
    - pkgs: {{ dependencies | json }}

pam-mount/package/install/{{ package }}/pkg.installed:
  pkg.installed:
    - name: {{ package }}
