module Danica
  class Operator::Functional < Operator
    variables :value
    default_value :is_grouped?, true

    def self.build(operator:, tex:, gnu:)
      Class.new(self) do
        define_method :to_f do
          Math.public_send(operator, value.to_f)
        end

        define_method :to_tex do
          tex.gsub(':value:', value.to_tex)
        end

        define_method :to_gnu do
          gnu.gsub(':value:', value.to_gnu)
        end
      end
    end
  end
end

