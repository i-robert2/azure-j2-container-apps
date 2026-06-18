# Azure J2 — Container Apps + GitHub Actions CI/CD

Containerize a small Python Flask API, push it to Azure Container Registry, deploy to Azure Container Apps with scale-to-zero autoscaling, and wire a GitHub Actions pipeline that runs the whole flow on every push to `main` — using **OIDC** (no long-lived secrets).

> Work in progress. Built as a hands-on learning project.

## Status

| Session | Scope | Status |
|---|---|---|
| 1 | Flask app + multistage Dockerfile + tests | in progress |
| 2 | Terraform: ACR + Container Apps environment + app | |
| 3 | OIDC federated credentials + GitHub secrets | |
| 4 | CI/CD pipeline (lint → test → SAST → build → push → deploy) | |
| 5 | Autoscale verification + teardown | |

## License

MIT — see [LICENSE](LICENSE).
