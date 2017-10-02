module Danica
  module DSL
    def sum(*args)
      Sum.new(*args)
    end
  end
end

