---
marp: true
theme: default
# class: invert
author: Petr Ankudinov
# size 16:9 1280px 720px
size: 16:9
paginate: true
math: mathjax
# backgroundImage: "linear-gradient(to bottom, #abbaab, #ffffff)"
# #ece9e6, #ffffff
# #8e9eab, #eef2f3
# #e6dada, #274046
# #abbaab, #ffffff
style: |
    :root {
      background: linear-gradient(to right, #abbaab, #ffffff);
    }
    img[alt~="custom"] {
      float: right;
    }
    .columns {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 1rem;
    }
    footer {
      font-size: 14px;
    }
    section::after {
      font-size: 14px;
    }
    img {
      background-color: transparent;
    }
    pre {
        background: linear-gradient(to bottom, #abbaab, #ffffff);
        background-color: transparent;
    }
---

# Ansible in a Devcontainer

<!-- Do not add page number on this slide -->
<!--
_paginate: false
-->

```text
Entire arista.avd ecosystem in a sealed bottle

Petr Ankudinov
Patrick Mathy
                                          2023
```

![bg right fit](img/avd-logo.webp)

---

# $ whoami

<style scoped>section {font-size: 18px;}</style>

<!-- Add footer starting from this slide -->
<!--
footer: '![h:20](https://www.arista.com/assets/images/logo/Arista_Logo.png)'
-->

- Petr Ankudinov [github.com/ankudinov](https://github.com/ankudinov)

  - Advanced Services Engineer at Arista Networks
  - Over 20 years of experience in IT with a bit of everything
  - ACE: L5, CCIE 37521
  - Passionate DC and network automation engineer
  - Daily (and nightly) user of Ansible, VSCode and more

- Patrick Mathy
  
  - Arista Systems Engineering at Arista Networks
  - Networking around since 2016
  - ACE: L5, CCIE 57751
  - R&S, DC, Python, Ansible, Terraform, DevNet

![bg right vertical w:200](img/pa-photo.jpg)
![bg right w:200](img/patrick-photo.jpg)

---

# Agenda

<style scoped>section {font-size: 22px;}</style>

![bg right](img/pexels-suzy-hazelwood-1226398.jpg)

- Ansible AVD collection overview
- Common challenges when building Ansible environment for network automation
- Why devcontainers?
- Pre-building a devcontainer with [arista.avd](https://avd.arista.com/), docker-in-docker and Containerlab using Github devcontainers/ci@v0.3 action.
- How to run the container on any machine (with docker run or as devcontainer) or Github Codespaces

---

# Credits and References

<style scoped>section {font-size: 22px;}</style>

<!-- Add footer starting from this slide -->
<!--
footer: '![h:20](https://www.arista.com/assets/images/logo/Arista_Logo.png)'
-->

This repository is based on many awesome open source repositories and some free/commercial Github features:

- [VS Code](https://code.visualstudio.com/)
- [DevContainers](https://code.visualstudio.com/docs/remote/containers)
- [Marp](https://marp.app/)
- [Excalidraw VS Code Plugin](https://github.com/excalidraw/excalidraw-vscode)
- [Github Actions](https://github.com/features/actions)
- [Github Pages](https://pages.github.com/)
- [Github Codespaces](https://github.com/features/codespaces)
- [Carbon](https://carbon.now.sh/)
- And many more...

All photos are taken from [Pexels](https://www.pexels.com/) and [Unsplash](https://unsplash.com/). Excellent free stock photos resources. It's not possible to reference every author individually, but their work is highly appreciated.

---

# What is Ansible AVD?

<style scoped>section {font-size: 22px;}</style>

- AVD stands for Arista Validated Design
- Documentation is available at [avd.arista.com](https://avd.arista.com/)
- Historically it is based on the [EVPN Deployment Guide](https://www.arista.com/custom_data/downloads/?f=/support/download/DesignGuides/EVPN_Deployment_Guide.pdf), but now it's much more advanced and developing fast.
- Ansible AVD repository is available here: [github.com/aristanetworks/ansible-avd](https://github.com/aristanetworks/ansible-avd)
- The Ansible AVD collection is relying on:
  - [EOS foundational modules](https://galaxy.ansible.com/arista/eos) maintained by RedHat: `ansible-galaxy collection install arista.eos`
  - [Ansible CVP modules](https://github.com/aristanetworks/ansible-cvp) to interact with CloudVision Portal when required
