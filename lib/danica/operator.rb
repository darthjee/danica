module Danica
  class Operator
    include Common
    include VariablesHolder
    include BaseOperations
    include ActiveModel::Model

    default_value :priority, 3
    default_value :is_grouped?, false
  
    def initialize(*args)
      super( variables: args.flatten )
    end

    def ==(other)
      return false unless other.class == self.class
      variables == other.variables
    end
  end
end
