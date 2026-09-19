FROM netboxcommunity/netbox:latest

COPY plugin_requirements.txt /opt/netbox/
RUN /usr/local/bin/uv pip install --no-cache -r /opt/netbox/plugin_requirements.txt

# Build-time + standalone: enable the plugin so collectstatic gathers its
# static files, and so users running without a config volume get a working
# image. At runtime, tedski's Ansible role mounts a read-only volume at
# /etc/netbox/config that shadows this file — keep both plugins.py lists
# in sync (repo's configuration/plugins.py and Ansible's files/plugins.py).
COPY configuration/plugins.py /etc/netbox/config/plugins.py
RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
