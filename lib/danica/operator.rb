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
  end
end
