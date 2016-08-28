# danica
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

    def spatial_velocity
      Product.new(variables: [ initial_velocity, time ])
    end

    def spatial_acceleration
      Division.new(numerator: Product.new(variables: [ acceleration, time, time ]), denominator: 2)
    end
  end
end
```

returns
```string
S_0+V_0\cdott+\frac{a\cdott\cdott}{2}
```

