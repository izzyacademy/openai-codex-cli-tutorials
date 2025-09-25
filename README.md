# OpenAI Codex CLI Tutorials

OpenAI Codex CLI Master Class

This is the accompanying repository for the master class where you will see links to resources that would help you follow along with the series.

The contents of this repo are available under the [IzzyAcademy License](LICENSE)

## Repository for Spec-Driven Development using Codex Agent

The following repositories will be used to manage development projects via SDD using Codex agents.

The project specifications will be provided and the Codex agent will use these instructions/requirements to generate the desired artifacts.

- [Application Infrastructure](https://github.com/izzyacademy/spec-driven-development-infrastructure) (Infrastructure as Code, Terraform)
- [Backend API Application](https://github.com/izzyacademy/spec-driven-development-backend-api) (Python, FastAPI)
- [Frontend UI Application](https://github.com/izzyacademy/spec-driven-development-frontend-ui) (Typescript, Angular)
  
We will use the Codex agent to create the automation scripts that will provision the infrastructure with Terraform, then the backend REST API application using FastAPI (python) and then the frontend UI application using Angular (Node/Typescript).
  
## About Codex CLI

Codex CLI is an *open-source coding agent* from OpenAI that you run locally in your terminal. It allows you to interact with your local codebase via natural-language prompts: read files, modify them, run commands, tests, etc. It supports operations like approving actions, sandboxing, non-interactive (CI) mode, image inputs, etc.

## How you can use it

Codex is available as a [CLI tool](https://developers.openai.com/codex/cli), as [an IDE extension/plugin](https://developers.openai.com/codex/ide) and also [in the Cloud](https://developers.openai.com/codex/cloud).

---

## Supported Operating Systems

* **macOS** — officially supported. 
* **Linux** — officially supported (various distros) 
* **Windows** — support is **experimental**, and generally recommended to run via WSL2 (Windows Subsystem for Linux) rather than as a fully native Windows install.

---

## System Requirements

Here are known / documented system requirements:

| Requirement                       | Details                                                                                                                                                                                                                                                                      |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **RAM**                           | Minimum: \~ 4 GB. Recommended: \~ 8 GB.                                                                                                                                                                                                                           |
| **Operating System Version**      | macOS 12 or higher; Ubuntu 20.04+ or Debian 10+; Windows 11 (via WSL2) for experimental support.                                                                                                                                                                  |
| **Git**                           | Optional but recommended (for built-in PR helpers). Version 2.23+ is mentioned.                                                                                                                                                                                    |
| **Disk space / Binary size**      | Not extremely heavy; you need to download the binary for your platform. The npm package has an unpacked size \~ 89-90 MB in some versions                                                                                                                       |
| **Network / Internet**            | Needed, since Codex CLI uses OpenAI API (or compatible backend) for model inference. The agent runs locally, but the models live remotely.                                                                                                        |
| **Sandboxing / Security Support** | To enable certain sandbox features (e.g. restricting file writes, network access), the OS must support sandbox APIs: on macOS using Apple Seatbelt / `sandbox-exec`; on Linux using Landlock / seccomp. These impose some constraints (e.g. in containers, etc.).  |

---
