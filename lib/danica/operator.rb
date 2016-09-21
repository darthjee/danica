module Danica
  class Operator < Common
    include ActiveModel::Model
  
    def initialize(*args)
      super( variables: args.flatten )
    end
  end
end
