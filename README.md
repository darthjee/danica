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


```ruby
class MyFunction < Danica::Function
  def to_f
    #implement to float method
  end

  def to_tex
    #implement to tex method
  end
end
```


### Sample

```ruby
require 'danica/function/product'
require 'danica/function/sum'
require 'danica/function/division'
require 'danica/function/power'

class Danica::Function
  class Spatial < Danica::Function
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

fx = Danica::Function.new(
  time: :t,
  acceleration: 'a',
  initial_space: { name: :S0, latex: 'S_0', gnu: 'S0' },
  initial_velocity: { name: :V0, latex: 'V_0', gnu: 'V0' }
)
```

```ruby
fx.to_tex
```

returns
```string
S_0 + V_0 \cdot t + \frac{a \cdot t^2}{2}
```

```ruby
fx.to_gnu
```

returns
```string
S0 + V0 * t + a * t**2/2
```

