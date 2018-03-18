module Danica
  class Operator::Power < Operator
    variables :base, :exponent
    default_value :is_grouped?, false

    def to_f
      base.to_f ** exponent.to_f
    end

    def to_tex(**options)
      "#{wrap_as_group(base).to_tex(options)}^{#{exponent.to_tex(options)}}"
    end

    def to_gnu(**options)
      "#{ wrap_as_group(base).to_gnu(options)}**(#{exponent.to_gnu(options)})"
    end
  end
end

