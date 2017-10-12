class Danica::Exception < ::Exception
  class NotDefined < self; end
  class FormatNotFound < self; end
  class NotImplemented < self; end
end

