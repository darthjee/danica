module Danica
  class Operator::Addition < Operator::Chained
    default_value :priority, 1

    def +(other)
      repack(other)
    end

    private

    default_value :symbol, :+

    def chain_operation(a, b)
      a + b
    end

    def join_proc(symbol, **_)
      proc do |_, value|
        value.signaled? ? ' ' : " #{symbol} "
      end
    end
  end
end

