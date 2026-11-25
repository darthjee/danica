# Architecture

## Overview

Danica is a Ruby gem for building, formatting and evaluating math expressions. Users compose expressions with the `Danica.build` DSL. Each expression is a tree of operators, wrappers and variables that can be rendered to text or LaTeX and calculated.

## Source Code Layout

All source code lives under `lib/`. `lib/danica.rb` is the entry point.

### `lib/danica/`
Top-level building blocks: `builder.rb`, `common.rb`, `base_operations.rb`, `expressable.rb`, `formatted.rb`, `exception.rb`, `version.rb`.

### `dsl/`
`Danica.build` DSL (`DSL::Builder`) used to write expressions.

### `operator/`
Operations as tree nodes: addition, multiplication, division, power, exponential, sin, cos, squared root, plus chained and functional bases.

### `wrapper/`
Leaf and wrapping nodes: number, constant, variable, group, negative, plus/minus, container.

### `function/`, `equation/`, `expression/`
Named functions, equations (`Equation::Builder`) and ready-made expressions (e.g. `Gauss`).

### `variables_holder/`
Variable management: store, calculator, aliasing and variable builders.
