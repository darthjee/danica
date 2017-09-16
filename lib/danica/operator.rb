module Danica
  class Operator
    include Common
    include ActiveModel::Model

    default_value :priority, 3
  
    def initialize(*args)
      super( variables: args.flatten )
    end
  end
end
