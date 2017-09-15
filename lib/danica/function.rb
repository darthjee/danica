module Danica
  class Function
    include Common
    include ActiveModel::Model
  
    attr_accessor :name

    default_value :priority, 3

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
