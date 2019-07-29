{%- from "netweaver/map.jinja" import netweaver with context -%}
{% set host = grains['host'] %}

{% for node in netweaver.nodes if host == node.host %}
{% if node.sap_instance.lower() == 'ascs' %}

mount_ascs_{{ netweaver.sid }}:
  mount.mounted:
    - name: /usr/sap/{{ netweaver.sid.upper() }}/ASCS00
    - device: {{ node.shared_disk_dev }}2
    - fstype: xfs
    - mkmnt: True
    - persist: True
    - opts:
      - defaults

{% elif node.sap_instance.lower() == 'ers' %}

mount_ers_{{ netweaver.sid }}:
  mount.mounted:
    - name: /usr/sap/{{ netweaver.sid.upper() }}/ERS10
    - device: {{ node.shared_disk_dev }}3
    - fstype: xfs
    - mkmnt: True
    - persist: True
    - opts:
      - defaults

{% endif %}
{% endfor %}