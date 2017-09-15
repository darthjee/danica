module Danica
  class Operator
    include Common
    include ActiveModel::Model
  
    def initialize(*args)
      super( variables: args.flatten )
    end
  end
end
