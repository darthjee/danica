module Danica
  class Function
    include Common
    include VariablesHolder
    include ActiveModel::Model
    include DSL
  
    attr_accessor :name

    default_value :priority, 3
    default_value :is_grouped?, false
    delegate :to_f, :to_tex, :to_gnu, to: :function_block

    def self.build(*vars, &block)
      Class.new(self) do
        variables(*vars)

        private

        define_method :function_block do
          @function ||= instance_eval(&block)
        end
      end
    end

    def initialize(*args)
      options = args.extract_options!

      super({ variables: args.flatten }.merge(options))
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
