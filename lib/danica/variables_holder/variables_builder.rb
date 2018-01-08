module Danica::VariablesHolder
  class VariablesBuilder
    include Danica::DSL
    include Danica::Wrapper

    attr_reader :instance, :attr_names

    def initialize(attr_names, instance)
      @instance = instance
      @attr_names = attr_names
    end

    def build
      names_hash = attr_names.extract_options!

      attr_names.each do |name|
        add_setter(name)
        add_reader(name)
        instance.variables_hash[name.to_sym] = wrap_value(name.to_sym)
      end

      names_hash.each do |name, default|
        add_setter(name)
        add_reader(name)
        instance.variables_hash[name.to_sym] = wrap_value(default)
      end
    end

    private

    def add_setter(name)
      instance.send(:define_method, "#{name}=") do |value|
        containers_hash[name.to_sym].content = wrap_value(value)
      end
    end

    def add_reader(name)
      instance.send(:define_method, name) do
        containers_hash[name.to_sym]
      end
    end
  end
end

