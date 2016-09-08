require 'concern_builder'
require 'bidu/core_ext'

class Danica::Function
  class VariablesBuilder < ::ConcernBuilder

    def init
      attr_names.each do |name|
        add_setter(name)
        add_reader(name)
      end
    end

    private

    def add_setter(name)
      code = <<-CODE
        @#{name} = value
      CODE
      add_method("#{name}=(value)", code)
    end

    def add_reader(name)
      code = <<-CODE
        @#{name}
      CODE
      add_method("#{name}", code)
    end
  end
end

