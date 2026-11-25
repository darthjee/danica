# Folder Structure

## Project Root

| Directory / File | Description |
|---|---|
| `lib/` | Gem source code (`danica.rb` entry point and `danica/` namespace). |
| `spec/` | RSpec tests: `lib/` unit specs mirroring the source, `integration/` specs, and `support/` helpers. |
| `config/` | Quality-tool configuration (yardstick, rubycritic, spec checks). |
| `scripts/` | Helper scripts (`check_readme.sh`, `rubycritic.sh`). |
| `.circleci/`, `circle.yml` | CI configuration. |
| `Dockerfile`, `docker-compose.yml`, `Makefile` | Dev/CI containers; `make dev` and `make ci` open shells in them. |
| `danica.gemspec`, `Gemfile` | Gem definition and dependencies. |
| `.rubocop.yml`, `.rubocop_todo.yml` | Lint configuration. |
| `docs/agents/` | Agent documentation, issues and plans. |
