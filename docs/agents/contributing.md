# Contributing

## Commit Guidelines

- **Atomic and Unitary:** Each commit must represent a single logical change.
  *Example:*
  - Good: `Add Danica::Operator::Cos#to_tex`
  - Bad: `Add Cos#to_tex and refactor VariablesHolder::Store`
- **No Unrelated Changes:** Do not mix unrelated changes in the same commit.
- **Separate Refactoring:** Whenever possible, separate refactoring commits from new feature or bugfix commits.

## Pull Requests

- **Descriptive Summary:** Every PR must include a clear and descriptive summary of its purpose and changes.
- **PR Description Files:** If a description cannot be provided directly in the PR, generate a file with the PR description (e.g., `docs/issues/<pr_number>_description.md`), but do not commit this file.

## Definition of Done for PRs

A PR is considered complete when:

- The stated objective has been achieved.
- All tests are passing.
- Linting passes without errors.
- Code coverage is as high as reasonably possible.
- Code is not overly complex:
  - Classes and methods should have clear, focused responsibilities.
  - Methods should be small and do exactly one thing. If a method is growing, extract parts into private helper methods or separate classes.
  - *Example:*

    ```ruby
    # Good: each method does one thing
    class Worker
      def fetch_job; end
      def process_job(job); end
    end

    # Bad: method does too much
    class Worker
      def run
        fetch_job
        process_job
        send_metrics
        cleanup
      end
    end
    ```

  - This requirement applies primarily to source code. For specs, refactor only if there is excessive duplication.

### CI Checks

Before a PR is considered complete, all CI checks must pass locally. CircleCI (`.circleci/config.yml`) runs two relevant jobs on every change:

| Modified folder | CircleCI job | Local commands |
| --- | --- | --- |
| `lib/`, `spec/` | `test` | `bundle exec rspec` |
| `lib/`, `spec/`, `config/`, `scripts/`, `README.md` | `checks` | `rubocop`, `bundle exec rake verify_measurements`, `check_readme.sh`, `rubycritic.sh`, `check_specs` |

The `build-and-release` job only runs on tags and `master`. Commands can be run inside the dev container (`make dev` / `make ci`).

This same process must be followed when **planning how to resolve an issue**: include a final step in the plan that identifies the affected folders and lists the CI commands to run before opening a PR.

## Code Organization

### File Responsibility

Every source file under `lib/` must declare classes or modules. Files must not execute logic or cause side effects at load time. `lib/danica.rb` is the only entrypoint (it loads/requires the namespace).

### File Naming: snake_case for Class Files

Files that define a class use **snake_case** matching the class name, and their specs mirror the path.

*Examples:*

- `lib/danica/operator/squared_root.rb` for `Danica::Operator::SquaredRoot`
- spec: `spec/lib/danica/operator/squared_root_spec.rb`

### Method Order: Public Before Private

Within a class, declare public methods before `private` ones; private methods are implementation helpers at the end of the class body.

```ruby
# Good
class Worker
  def run
    prepare
    execute
  end

  private

  def prepare; end
  def execute; end
end
```

## Dependency Injection

Classes must receive their dependencies (data, configuration, collaborators) as constructor arguments. A class must never reach out to load files, read environment variables, or fetch configuration on its own. This keeps every class independently testable.

```ruby
# Good
class Router
  def initialize(data)
    @data = data
  end
end

# Bad
class Router
  def build
    data = YAML.load_file('./data.yml')
  end
end
```

## Documentation

Public classes and methods must be documented with YARD; the `verify_measurements` rake task enforces documentation coverage. Update `README.md` when behavior or version changes (`check_readme.sh` verifies the version).

## Refactoring Guidelines

When refactoring, aim to:

- **Reduce Code Duplication:** e.g. move repeated spec setup into `let`/shared contexts or factory helpers in `spec/support/`.
- **Keep Classes Focused:** extract collaborators when a class takes on more than one responsibility.
- **Keep RuboCop and RubyCritic Green:** do not add entries to `.rubocop_todo.yml` to hide new offenses.
