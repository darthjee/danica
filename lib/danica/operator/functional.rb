module Danica
  class Operator::Functional < Operator
    variables :value
    default_value :is_grouped?, true

    def self.build(operator:, text: nil, tex: nil, gnu: nil)
      text = "#{operator}(:value:)" if text.nil?
      tex = text if tex.nil?
      gnu = text if gnu.nil?

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

