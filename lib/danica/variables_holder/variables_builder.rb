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
      code = <<-CODE
        variables_hash[:#{name}] = wrap_value(value)
        @variables = variables_hash.values
      CODE
      add_method("#{name}=(value)", code)
    end

    def add_reader(name, default)
      code = <<-CODE
        variables_hash[:#{name}] ||= wrap_value(#{default.is_a?(Hash) ? default : ":#{default}"})
      CODE
      add_method("#{name}", code)
    end
  end
end

