class Danica::Exception < ::Exception
  class NotDefined < self; end
  class FormattedNotFound < self; end
  class NotImplemented < self; end
end

