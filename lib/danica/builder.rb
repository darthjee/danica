module Danica
  class Builder
    include DSL

    def build(&block)
      instance_eval(&block)
    end
  end
end
