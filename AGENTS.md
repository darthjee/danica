# Project Instructions

Danica is a Ruby gem for building and formatting math expressions (a DSL for math formulation on docs). Expressions are built via `Danica.build { ... }` and can be rendered/formatted (e.g. LaTeX, plain text) and evaluated.

## Stack

- Ruby >= 3.3.1 (gem)
- ActiveSupport ~> 7.2, darthjee-core_ext ~> 3
- RSpec for tests, RuboCop (with rubocop-rspec) for linting
- CircleCI for CI; Docker / docker-compose for development (`make dev`, `make ci`)

## Conventions

- Source lives in `lib/danica/`, specs in `spec/` mirroring the `lib/` layout.
- Follow `.rubocop.yml`; run RuboCop and RSpec before committing.
- Keep `# frozen_string_literal: true` at the top of Ruby files and document public APIs with YARD.

## Documentation

All project documentation lives under [`docs/agents/`](docs/agents/):

| File | Contents |
|------|----------|
| [Folder Structure](docs/agents/folder-structure.md) | Top-level directory layout and the role of each folder. |
| [Architecture](docs/agents/architecture.md) | Source layout, modules, code style, and implementation guidelines. |
| [Flow](docs/agents/flow.md) | Main runtime flow of the application. |
| [Plans](docs/agents/plans/) | Implementation plans for ongoing or upcoming features. |
| [Issues](docs/agents/issues/) | Detailed specs for open issues. |

### Issues (`docs/agents/issues/`)

Each file documents an issue in detail. Naming convention:

```
docs/agents/issues/<issue_id>_<issue_name>.md
```

Example: `docs/agents/issues/5_release_docker_image.md` for issue #5.

### Plans (`docs/agents/plans/`)

Each plan is a directory named after the issue ID and topic, containing one or more related files:

```
docs/agents/plans/<issue_id>_<topic>/<related_files>.md
```

Example: `docs/agents/plans/12_add-auth/plan.md` for issue #12.
| [Contributing](docs/agents/contributing.md) | Commit guidelines, PR standards, code organization, and refactoring rules. |

## Commit Attribution

Commit co-author trailers follow arcanum's resolved `git.omit_model_coauthor` and `git.remove_coauthors` config (check them with `/arcanum-check-config`); this overrides Claude Code's own attribution reminder for every commit, including ones written by hand.
