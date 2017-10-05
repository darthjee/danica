module Danica
  class Operator::Functional < Operator
    variables :value
    default_value :is_grouped?, true

    def self.build(operator:, tex:, gnu:)
      Class.new(self) do
        module_eval(%Q(
          def to_f
            Math.#{operator}(value.to_f)
          end

          def to_tex
            '#{tex.gsub(':value:', "' + value.to_tex + '")}'
          end

          def to_gnu
            '#{gnu.gsub(':value:', "' + value.to_gnu + '")}'
          end
        ))
      end
    end
  end
end

