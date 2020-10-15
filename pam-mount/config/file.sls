# -*- mode: salt; coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pam_mount with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

pam-mount/config/file/file.managed:
  file.managed:
    - name: {{ pam_mount.config }}
    - source: {{ files_switch(['pam_mount.conf.xml.jinja', 'pam_mount.conf.xml'],
                              lookup='pam-mount/config/file/file.managed'
                 )
              }}
    - mode: 644
    - template: jinja
    - context:
        pam_mount: {{ pam_mount | json }}
    - require:
      - sls: {{ sls_package_install }}
