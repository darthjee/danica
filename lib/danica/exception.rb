# frozen_string_literal: true

class Danica::Exception < RuntimeError
  class NotDefined < self; end
  class FormattedNotFound < self; end
  class NotImplemented < self; end

  class InvalidInput < self
    attr_reader :value

    def initialize(value)
      @value = value
      super
    end

    def message
      "invalid input class #{value.class}"
    end
  end
end
