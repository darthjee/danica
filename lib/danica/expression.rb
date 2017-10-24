module Danica
  class Expression
    include Common
    include VariablesHolder
    include DSL

    delegate :to_f, :to, :is_grouped?, :priority, to: :expression_block

    def self.build(*vars, &block)
      Class.new(self) do
        variables(*vars)

        private

        define_method :expression_block do
          @function_block ||= instance_eval(&block) if block
        end
      end
    end

    def self.create(*vars, &block)
      build(*vars, &block).new
    end

    def initialize(*args)
      options = args.extract_options!

      attributes = { variables: args.flatten }.merge(options)

      attributes.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

    def calculate(*args)
      vars_map = args.extract_options!
      vars_map = variables_value_hash.merge(vars_map)
      vars_map.each do |k, v|
        unless v && (v.is_a?(Integer) || v.valued?)
          vars_map[k] = args.shift
        end
      end

      self.class.new(vars_map).to_f
    end
  end
end
