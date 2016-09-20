module Danica
  class Operator < Danica::Common
    include ActiveModel::Model
  
    def initialize(*args)
      options = args.extract_options!

      super({ variables: args.flatten }.merge(options))
    end
  end
end
