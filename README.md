# Ansible in a Devcontainer

To access the materials for this session, please use following links:

- [Web Slides (Recommended)](https://ankudinov.github.io/ansible-devcontainer/)
- [PDF Slides](https://github.com/ankudinov/ansible-devcontainer/blob/gh-pages/avd_extended_workshop.pdf)

> To run the demo, you have to set the ARTOKEN secret in `Settings > Secrets and Variables > Codespaces`. This must be the same as your Arista profile token to allow cEOS image download. If you are not able to generate the token, please upload cEOS image manually or limit the demo steps 1-3.

Demo steps:

- Start devcontainer as Github Codespace
- Execute `make start` to start the lab
- Execute `make build` to build the configs
- Execute `make deploy` to deploy the configs
- Execute `make test` to verify the lab
