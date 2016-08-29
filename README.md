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
class Danica::Function
  class Spatial < Danica::Function
    attr_accessor :time, :acceleration, :initial_space, :initial_velocity
    delegate :to_tex, to: :sum

    private

    def sum
      @sum ||= Sum.new(variables: parcels)
    end

    def parcels
      [
        initial_space,
        spatial_velocity,
        spatial_acceleration
      ]
    end

    def spatial_acceleration
      Division.new(numerator: Product.new(variables: [ acceleration, time_squared ]), denominator: 2)
    end

    def time_squared
      Power.new(base: time, exponent: 2)
    end
  end
end

Danica::Function.new(
  time: :t,
  acceleration: 'a',
  initial_space: { name: :S0, latex: 'S_0' },
  initial_velocity: { name: :V0, latex: 'V_0' }
).to_tex
```

returns
```string
S_0 + V_0 \cdot t + \frac{a \cdot t^2}{2}
```

