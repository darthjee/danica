module Danica
  module VariablesHolder
    class Dummy
      include Common
      include VariablesHolder

      variables :x, y: { latex: '\y' }, z: 10

      delegate :to, :to_f, to: :block

      def initialize(vars = {})
        self.variables=vars
      end

      def block
        x ** y + z
      end
    end

    class DummyChild < Dummy
      variables :k, z: { name: 'zeta' }
    end

    class DummyOverwrite < Dummy
      variables :w
      reset_variables
      variables :k, z: { name: 'zeta' }
    end

    class DummyAlias < Dummy
      variable_alias :x, :a
    end
  end
end
