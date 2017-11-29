class Danica::VariablesHolder::Dummy
  include Danica::Common
  include Danica::VariablesHolder

  variables :x, y: { latex: '\y' }, z: 10

  def initialize(vars = {})
    self.variables=vars
  end
end

class Danica::VariablesHolder::DummyChild < Danica::VariablesHolder::Dummy
  variables :k, z: { name: 'zeta' }
end

class Danica::VariablesHolder::DummyOverwrite < Danica::VariablesHolder::Dummy
  variables :w
  reset_variables
  variables :k, z: { name: 'zeta' }
end

class Danica::VariablesHolder::DummyAlias < Danica::VariablesHolder::Dummy
  variable_alias :x, :a
end

