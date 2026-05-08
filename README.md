# sebcel-chocoop-infra

Shared AWS infrastructure for the Chores Cooperative ecosystem.

This repository contains Terraform code responsible for provisioning and managing infrastructure shared by multiple Chores Cooperative components.

The repository is intentionally limited in scope and does not contain application-specific resources.

---

## Purpose

The main goals of this repository are:

- provision shared AWS infrastructure
- support independent deployments of system components
- centralize ownership of shared resources
- provide Infrastructure as Code (IaC) using Terraform
- provide automated deployments using GitHub Actions

---

## Current Scope

Currently managed resources:

- AWS EventBridge Bus
- EventBridge policies
- Terraform remote state infrastructure
  - S3 backend bucket
  - DynamoDB state locking

---

## Non-Goals

This repository does NOT contain:

- application Lambdas
- service-specific infrastructure
- frontend infrastructure
- application storage
- SES configuration
- component-specific IAM roles

Those resources belong to their owning repositories.

---

## Repository Structure

    .
    ├── README.md
    ├── docs/
    ├── scripts/
    ├── build/
    ├── terraform/
    │   ├── bootstrap/
    │   ├── modules/
    │   ├── environments/
    │   │   ├── dev/
    │   │   └── prod/
    │   └── root/
    └── .github/
        └── workflows/

---

## Terraform Structure

### bootstrap

Contains Terraform code responsible for creating Terraform backend infrastructure.

Resources created here:

- S3 bucket for Terraform state
- DynamoDB table for Terraform locking

Bootstrap uses local Terraform state.

---

### root

Main Terraform root module.

Contains:

- providers
- variables
- locals
- outputs
- shared infrastructure modules

---

### modules

Reusable Terraform modules.

Currently:

- `eventbridge-bus`

---

### environments

Environment-specific Terraform configuration.

Supported environments:

- `dev`
- `prod`

Each environment has:
- separate Terraform state
- separate backend configuration
- separate variables

---

## Environments

### Development

Shared development environment.

Characteristics:

- deployed from any non-main branch
- unstable by design
- used for experiments and integration testing

Resource naming example:

    sebcel-chocoop-infra-bus-dev

---

### Production

Stable production environment.

Characteristics:

- deployed only from `main`
- intended for stable releases

Resource naming example:

    sebcel-chocoop-infra-bus-prod

---

## Naming Convention

AWS resources follow the format:

    sebcel-chocoop-<component>-<resource>-<environment>

Examples:

    sebcel-chocoop-infra-bus-dev
    sebcel-chocoop-notifications-function-prod
    sebcel-chocoop-kimbalontek-role-dev

---

## Tagging Convention

All resources must contain the following tags:

| Tag | Purpose |
|------|------|
| Name | Human-readable resource name |
| application | System identifier |
| component | Logical component owner |
| environment | Deployment environment |
| owner | Resource owner |
| managed-by | Infrastructure management tool |

Example:

    Name = sebcel-chocoop-infra-bus-dev
    application = sebcel-chocoop
    component = infra
    environment = dev
    owner = Sebastian.Celejewski@wp.pl
    managed-by = terraform

---

## Deployment Model

### Development

All non-main branches deploy automatically to the shared DEV environment.

### Production

Only the `main` branch may deploy to PROD.

Deployments are executed using GitHub Actions.

---

## Terraform Backend

Terraform remote state is stored in AWS.

Backend components:

- S3 bucket for state storage
- DynamoDB table for state locking

State separation is implemented per environment.

Example:

    dev/terraform.tfstate
    prod/terraform.tfstate

---

## GitHub Actions

Deployments are performed using GitHub Actions with AWS OIDC authentication.

No long-lived AWS credentials are stored in GitHub Secrets.

---

## Related Repositories

    sebcel-chocoop-app
    sebcel-chocoop-notifications
    sebcel-chocoop-kimbalontek
    sebcel-chocoop-architecture

---

## Architecture Documentation

Architecture documentation, diagrams, ADRs, and event contracts are stored in:

    sebcel-chocoop-architecture
