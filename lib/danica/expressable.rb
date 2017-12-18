module Danica
  module Expressable extend ::ActiveSupport::Concern
    included do
      class << self
        def build(*vars, &block)
          Class.new(self) do
            variables(*vars)

            private

            define_method :function_block do
              @function_block ||= instance_eval(&block) if block
            end
          end
        end

        def create(*vars, &block)
          build(*vars, &block).new
        end
      end
    end
  end
end
