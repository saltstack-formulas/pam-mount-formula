# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as pam_mount with context %}

pam-mount-package-install-pkg-installed:
  pkg.installed:
    - name: {{ pam_mount.pkg.name }}
