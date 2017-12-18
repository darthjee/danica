module Danica
  module Expressable extend ::ActiveSupport::Concern
    included do
      include VariablesHolder

      class << self
        def built_with(block_name)
          self.send(:define_singleton_method, :build) do |*vars, &block|
            Class.new(self) do
              variables(*vars)

              private

              module_eval("define_method :#{block_name} do
                @#{block_name} ||= instance_eval(&block) if block
              end")
            end
          end

          self.send(:define_singleton_method, :create) do |*vars, &block|
            build(*vars, &block).new
          end
        end
      end
    end
  end
end
