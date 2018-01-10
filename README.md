# danica
[![Code Climate](https://codeclimate.com/github/darthjee/danica/badges/gpa.svg)](https://codeclimate.com/github/darthjee/danica)
[![Test Coverage](https://codeclimate.com/github/darthjee/danica/badges/coverage.svg)](https://codeclimate.com/github/darthjee/danica/coverage)

A tool for math formulation on docs

## How to use
Add the gem to your project or just install the gem

```ruby
gem 'danica'
```

```bash
bundle install danica
```

Now you can use in your project

### Quick Use
Use Danica build to build and use your expression using ```Danica.build```
```ruby
expression = Danica.build do
  (number(1) + 2) * power(3,4)
end
```

create and use functions

```ruby
func = Danica.build do
  Danica::Function.create(:x, :y) do
    (number(1) + x) * power(3, y)
  end
end

func.to_gnu
```

create gnu or tex output strings to be used on your template

### Operators
Operators represent a matematical operation such as sum, product, sin, etc..

Operators are to be composed to create an [expression](#expressions), [equation](#equations) or [function](#functions) (see below)

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
end
```

#### Sample
```ruby
class Danica::Operator::Inverse < Danica::Operator

  variables :value

  def to_f
    value.to_f ** -1 #Do not worry with nil value as this has been implemented already raising Danica::Exception::NotDefined
  end

  def to_tex
    "(#{value.to_tex})^{-1}"
  end

  def to_gnu
    "(#{value.to_gnu}) ** -1"
  end
end

fx = Danica::Operator::Inverse.new(:x)
```

##### to_tex
```ruby
fx.to_tex
```

returns
```tex
(x)^{-1}
```

##### to_gnu
```ruby
fx.to_gnu
```

returns
```gnuplot
(x) ** -1
```

##### calculate / to_f
```ruby
fx.calculate(2)
```
or
```ruby
Danica::Operator::Inverse.new(2).to_f
```

both return
```float
0.5
```

### Expressions

Expressions  are composition of operators threating their variables input.

Example of expression could be ```x ^ y + y / 2``` which is composed of an operator sum of 2 parcels,
being the first an operator power and the second an operator division, while the variable ```x``` is only used
as the base of the power operator and the y variable is present on both power and division operator

Expressions can be defined on the fly or as a class

```ruby
clazz = Danica::Expression.build(:a, :b, :c) do
  (
    negative(b) + Danica::Wrapper::PlusMinus.new(
      squared_root(
        power(b, 2) - multiplication(4, a, c)
      )
    )
  ) / (number(2) * a)
end
```

```ruby
module Danica
  class Expression::Baskara < Expression.build(:a, :b, :c) { numerator / denominator }

    private

    def numerator
       negative(b) + Wrapper::PlusMinus.new(squared_root(delta))
    end

    def denominator
      number(2) * a
    end

    def delta
      power(b, 2) - multiplication(4, a, c)
    end
  end
end
clazz = Danica::Expression::Baskara
```

Both would create a class whose instance knows how to build baskara formula

```ruby
clazz.new.to_tex
```

```tex
\frac{-b \pm \sqrt{b^{2} -4 \cdot a \cdot c}}{2 \cdot a}
```

### Equations

Equations are formed by two expressions with their own variables

```ruby
Danica::Equation.build(:x, :y, :z) do
  left { x ** 2 + y ** 2 }
  right { number(1) - z ** 2 }
end.new.to_tex
```

```ruby
Danica::Equation.create(:x, :y, :z) do
  left { x ** 2 + y ** 2 }
  right { number(1) - z ** 2 }
end.to_tex
```

so we can create the equation

```gnuplot
x**(2) + y**(2) = 1 -z**(2)
```

### Functions

Functions are equations whose one of the sides is actually the naming of the function and variables declaration

Example of function could be ```f(x,y) = x ^ y + y / 2``` which is composed of an operator sum of 2 parcels,
being the first an operator power and the second an operator division, while the variable ```x``` is only used
as the base of the power operator and the y variable is present on both power and division operator

```ruby
class MyFunction < Danica::Function
  variables :x, :y ...

  def function_block
    #your code goes here
  end
end
```

#### Sample
```ruby
module Danica
  class Function::Spatial < Function
    variables :time, :acceleration, :initial_space, :initial_velocity

    private

    def function_block
      @function_block ||= addition(parcels)
    end

    def parcels
      [
        initial_space,
        spatial_velocity,
        spatial_acceleration
      ]
    end

    def spatial_velocity
      multiplication(initial_velocity, time)
    end

    def spatial_acceleration
      division(multiplication(acceleration, time_squared), 2)
    end

    def time_squared
      power(time, 2)
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
```tex
f(t, a, S_0, V_0) = S_0 + V_0 \cdot t + \frac{a \cdot t^{2}}{2}
```

##### to_gnu
```ruby
fx.to_gnu
```

returns
```gnuplot
f(t, a, S0, V0) = S0 + V0 * t + (a * t**(2))/(2)
```

##### calculate / to_f
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

#### Danica::Function.build
Alternativily, a function can be created through ```Danica::Function.build(*variables, &block)```

```ruby
class Saddle < Danica::Function.build(:x, :y) { power(x, 2) - power(y, 2) }
end

fx = Saddle.new
```

or

```ruby
fx = Danica::Function.build(:x, :y) { power(x, 2) - power(y, 2) }.new
```

##### to_tex
```ruby
fx.to_tex
```

returns
```tex
x^{2} -y^{2}
```

##### to_gnu
```ruby
fx.to_gnu
```

returns
```gnuplot
x**(2) -y**(2)
```
### DSL and building
An expression can be created using the DSL direct from ```Danica```

```ruby
Danica.build do
  power(:x, -1)
end
```

will result into a ```Danica::Operator::Power``` wrapped into an ```Danica::Expression```

```ruby
Danica::Operator::Power.new(:x, -1)
```

#### Operator registration on DSL

Any operator created can be added to the DSL by running ```DSL.register_operator```

```ruby
module Danica
  class Operator::Inverse < Danica::Operator
    include DSL
    variables :value

    delegate :to_f, :to_tex, :to_gnu, to: :pow

    def pow
      @pow ||= power(value, -1)
    end
  end
end
```

In order to add the new operator, DSL cna infer by the name ```inverse``` which results in ```Danica::Operator::Inverse```

```ruby
Danica::DSL.register_operator(:inverse)
```

or

```ruby
Danica::DSL.register(:inverse, Danica::Operator::Inverse)
```

This will allow the usage of the inverse function

```ruby
Danica.build do
  inverse(:x)
end
```

will result into a ```Danica::Operator::Inverse``` object

```ruby
Danica::Operator::Inverse.new(:x)
```

### Variables
Variables are instances of ```Danica::Wrapper::Variable``` having the optional attributes
```name```, ```gnu``` , ```latex``` and ```value```

The initialization of the variable can be made through the class, DSL or when initializing an operator

```ruby
  Danica::Wrapper::Variable.new(:x)
```

```ruby
  Danica::Wrapper::Variable.new(name: :x)
```

```ruby
Danica::DSL.build do
  variable(:x)
end
```

all will create the same variable that can be coverted ```#to_tex```

```string
x
```

When using it with function, operators or other ```Danica::Common``` objects, the variables are wrapped
automatically

```ruby
Danica::DSL.build do
  power(:x, { name: :y }) + :z
end
```

will result in

```ruby
Danica::Operator::Addition.new(
  Danica::Operator::Power.new(
    Danica::Wrapper::Variable.new(:x), 
    Danica::Wrapper::Variable.new(:y) 
  ),
  Danica::Wrapper::Variable.new(:z) 
)
```

Variables can also behave differently when converting to tex or gnu

```ruby
Danica::DSL.build do
  variable(name: :frequency, latex: '\lambda', gnu: :f)
end
```
would produce different ```#to_tex``` and ```#to_gnu``` results (```\lambda``` and ```f``` respectvly)

#### #to_f

Variables can be used to calculate the value of an expression by usage of the value attribute

```ruby
Danica::DSL.build do
  variable(name: :x, value: 2)
end
```

with will respond to ```#tot_f``` as ```2```

It can be used when calculating an expression later

```ruby
x = Danica::DSL.build do
  variable(:x)
end

p = Danica::DSL.build do
  power(x, 2)
end

x.value = 4
p.to_f
```

which will return ```16```

### Number
Numberss are simple wrappers using ```Danica::Wrapper::Number```

they can be initialized explicitly, through the DSL or whenever an operation is made with other ```Danica``` objects

```ruby
Danica::Wrapper::Number.new(3)
```

```ruby
Danica::DSL.build do
  number(3)
end
```

will both return the number object that can be used to generate tex, gnu or float outputs (for calculation)

Other ways of creating instances of number is when using it as a right side element in basic operations such as sum
or when using it as the parameter of any other class such as functions and operators

```ruby
Danica::DSL.build do
  power(:x, 2) + 3
end
```

will create

```ruby
Danica::Operator::Addition.new(
  Danica::Operator::Power.new(
    Danica::Wrapper::Variable.new(:x), 
    Danica::Wrapper::Number.new(2)
  ),
  Danica::Wrapper::Number.new(3)
)
```
