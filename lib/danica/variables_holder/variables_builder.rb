# frozen_string_literal: true

module Danica::VariablesHolder
  class VariablesBuilder
    include Danica::DSL
    include Danica::Wrapper

    attr_reader :instance, :attr_names, :names_hash

    def initialize(instance, attr_names)
      @instance = instance
      @attr_names = attr_names
      @names_hash = attr_names.extract_options!.symbolize_keys
    end

    def build
      attr_names.map(&:to_sym).each do |name|
        build_variable(name, name)
      end

      names_hash.each do |name, default|
        build_variable(name, default)
      end
    end

    private

    def build_variable(name, default)
      add_setter(name)
      add_reader(name)
      instance.variables_hash[name] = wrap_value(default)
    end

    def add_setter(name)
      instance.send(:define_method, "#{name}=") do |value|
        containers_hash[name].content = wrap_value(value)
      end
    end

    def add_reader(name)
      instance.send(:define_method, name) do
        containers_hash[name]
      end
    end
  end
end
