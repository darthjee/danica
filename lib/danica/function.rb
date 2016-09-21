module Danica
  class Function < Common
    include ActiveModel::Model
  
    attr_accessor :name

    def initialize(*args)
      options = args.extract_options!

      super({ variables: args.flatten }.merge(options))
    end
  end
end
