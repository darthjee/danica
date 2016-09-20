require 'concern_builder'
require 'bidu/core_ext'

class Danica::Operator
  class VariablesBuilder < ::ConcernBuilder
    attr_reader :instance

    def init
      attr_names.each do |name|
        add_setter(name)
        add_reader(name)
        instance.send(:variables_names) << name
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

    def add_reader(name)
      code = <<-CODE
        variables_hash[:#{name}]
      CODE
      add_method("#{name}", code)
    end
  end
end

