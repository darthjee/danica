require 'concern_builder'
require 'darthjee/core_ext'

module Danica::VariablesHolder
  class VariablesBuilder < ::ConcernBuilder
    attr_reader :instance

    def init
      attr_names.extract_options!.each do |name, default|
        add_setter(name)
        add_reader(name, default)
        instance.variables_names << name
      end

      attr_names.each do |name|
        add_setter(name)
        add_reader(name, name)
        instance.variables_names << name
      end
    end

    private

    def add_setter(name)
      instance.send(:define_method, "#{name}=") do |value|
        variables_hash[name.to_sym] = wrap_value(value)
        @variables = variables_hash.values
      end
    end

    def add_reader(name, default)
      instance.send(:define_method, name) do
        variables_hash[name.to_sym] ||= wrap_value(default)
      end
    end
  end
end

