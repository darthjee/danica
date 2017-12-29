
module Danica
  class LegacyFunction::Hyperbole < LegacyFunction.build(:x) { Danica::Hyperbole.new }
  end
end

module Danica
  class LegacyFunction::SaddleHyperbole < LegacyFunction::Hyperbole
    variables :y

    def function_block
      super - power(y, 2)
    end
  end
end

