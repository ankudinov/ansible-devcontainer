ARG FROM_IMAGE
ARG FROM_VARIANT

FROM ${FROM_IMAGE}:${FROM_VARIANT}

ARG AVD_VERSION
ARG ANSIBLE_CORE_VERSION
ARG USERNAME
ARG GIT_REPO_NAME
ARG CLAB_VERSION

# install some basic tools inside the container
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    sshpass \
    curl \
    iputils-ping \
    htop \
    # add chromium for marp slides
    chromium \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# switch non-root user otherwise Ansible will be installed as root
USER ${USERNAME}
ENV PATH=$PATH:/home/${USERNAME}/.local/bin
ENV ANSIBLE_CONFIG="/workspaces/${GIT_REPO_NAME}/avd_inventory/ansible.cfg"
# install Ansible AVD collection
RUN pip3 install "${ANSIBLE_CORE_VERSION}" \
    && ansible-galaxy collection install arista.avd:==${AVD_VERSION} \
    && pip3 install -r /home/${USERNAME}/.ansible/collections/ansible_collections/arista/avd/requirements.txt

# install the latest containerlab and yamllint
RUN bash -c "$(curl -sL https://get.containerlab.dev)" -- -v ${CLAB_VERSION} \
    && pip3 install --user yamllint
