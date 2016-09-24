# danica
[![Code Climate](https://codeclimate.com/github/darthjee/danica/badges/gpa.svg)](https://codeclimate.com/github/darthjee/danica)
[![Test Coverage](https://codeclimate.com/github/darthjee/danica/badges/coverage.svg)](https://codeclimate.com/github/darthjee/danica/coverage)

A tool for math formulation on docs

## How to use
Add the gem to your project or just install the gem

```
gem 'danica'
```

```console
bundle install danica
```

Now you can use in your project

### Operators
Operators are much like function, but they do not have a name.

While a function would be something in the format ```f(x) = x + 1```, an operator would just represent the sum ```x + 1```

Operators are to be composed to create a Function (see below) being their difference almost semantic

```ruby
class MyOperator < Danica::Operator
  variables :elements_list
  def to_f
    #implement to float method
  end

  def to_tex
    #optionaly implement custom to_tex method
  end

  def to_gnu
    #optionaly implement custom to_gnu method
  end

  private

  def tex_string
    #implement tex_string here
  end

  def gnu_string
    #implement gnu_string here
  end
end
```
#### Sample
```ruby
class Danica::Inverse
  variables :value

  def to_f
    value.to_f ** -1 #Do not worry with nil value as this has been implemented already raising Danica::Exception::NotDefined
  end

  private

  def tex_string
    "(#{value.to_tex})^{-1}"
  end

  def gnu_string
    "(#{value.to_gnu}) ** -1"
  end
end

fx = Danica::Inverse.new(:x)
```

##### to_tex
```ruby
fx.to_tex
```

returns
```string
(x)^{-1}
```

##### to_gnu
```ruby
fx.to_gnu
```

returns
```string
(x) ** -1
```

##### calculate / to_f
```ruby
fx.calculate(2)
```
or
```ruby
Danica::Inverse.new(2).to_f
```

both return
```string
0.5
```

### Functions

Functions are composition of operators threating their variables input.

Example of function could be ```f(x,y) = x ^ y + y / 2``` which is composed of an operator sum of 2 parcels,
being the first an operator power and the second an operator division, while the variable ```x``` is only used
as the base of the power operator and the y variable is present on both power and division operator

```ruby
class MyFunction
  variables :variables_list

  # code of operators composition
end
```

#### Sample
```ruby
require 'danica/operator/product'
require 'danica/operator/sum'
require 'danica/operator/division'
require 'danica/operator/power'

module Danica
  class Function::Spatial < Function
    variables :time, :acceleration, :initial_space, :initial_velocity
    delegate :to_tex, :to_gnu, to: :sum

    private

    def sum
      @sum ||= Sum.new(parcels)
    end

    def parcels
      [
        initial_space,
        spatial_velocity,
        spatial_acceleration
      ]
    end

    def spatial_velocity
      Product.new(initial_velocity, time)
    end

    def spatial_acceleration
      Division.new(Product.new(acceleration, time_squared), 2)
    end

    def time_squared
      Power.new(time, 2)
    end
  end
end

fx = Danica::Function::Spatial.new(
  time: :t,
  acceleration: 'a',
  initial_space: { name: :S0, latex: 'S_0', gnu: 'S0' },
  initial_velocity: { name: :V0, latex: 'V_0', gnu: 'V0' }
)
```

##### to_tex
```ruby
fx.to_tex
```

returns
```string
S_0 + V_0 \cdot t + \frac{a \cdot t^2}{2}
```

##### to_gnu
```ruby
fx.to_gnu
```

returns
```string
S0 + V0 * t + a * t**2/2
```

##### to_gnu
```ruby
fx = Danica::Function::Spatial.new(
  time: :t,
  acceleration: :a,
  initial_space: 1,
  initial_velocity: 2
)
```

```ruby
fx.calculate(10, 3)
```

or


```ruby
fx.calculate(time: 10, acceleration: 3)
```

or

```ruby
Danica::Function::Spatial.new(10, 3, 1, 2).to_f
```

all return

```ruby
171.0
```
