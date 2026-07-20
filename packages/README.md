# Reusable packages

This directory contains shared Flutter infrastructure extracted only when it solves a real reuse problem.

Planned package responsibilities:

- `app_core` - shared application primitives and result/error types.
- `design_system` - tokens, typography, spacing, and reusable UI components.
- `network` - configured HTTP client, interceptors, and API result mapping.
- `storage` - secure and local persistence abstractions.
- `logger` - structured logging and environment-aware output.

Each package should remain independently testable and documented with a small usage example.
