module Danica
  module Expressable extend ::ActiveSupport::Concern
    include VariablesHolder

    class_methods do
      def built_with(block_name)
        self.delegate :to, :to_f, to: block_name

        self.define_singleton_method(:build) do |*vars, &block|
          Class.new(self) do
            variables(*vars)

            private

            module_eval("define_method :#{block_name} do
                @#{block_name} ||= instance_eval(&block) if block
              end")
          end
        end

        self.define_singleton_method(:create) do |*vars, &block|
          build(*vars, &block).new
        end
      end
    end

    def initialize(*args)
      options = args.extract_options!

      attributes = { variables: args.flatten }.merge(options)

      attributes.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end
  end
end
