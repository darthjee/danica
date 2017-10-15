module Danica
  class Operator::Addition < Operator::Chained
    default_value :priority, 1

    def +(other)
      repack(other)
    end

    private

    default_value :tex_symbol, :+
    alias_method :gnu_symbol, :tex_symbol

    def chain_operation(a, b)
      a + b
    end

    def join_proc(symbol)
      proc do |_, value|
        value.is_a?(Wrapper::Negative) || value.is_a?(Wrapper::PlusMinus) ? ' ' : " #{symbol} "
      end
    end
  end
end

