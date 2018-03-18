module Danica
  module DSL
    class Builder
      attr_reader :instance, :method, :claz, :base

      def initialize(instance, method, claz=nil, base=nil)
        @instance = instance
        @method = method
        @claz = claz
        @base = base
      end

      def build
        clas = clazz
        instance.send(:define_method, method) do |*args|
          clas.new(*args)
        end
      end

      def clazz
        @clazz ||= build_clazz
      end

      def build_clazz
        return clazz_from_method unless claz
        return claz if claz.is_a? Class
        clazz_from_string
      end

      def clazz_from_method
        [base.to_s, method.to_s.camelize].compact.join('::').constantize
      end

      def clazz_from_string
        [base, claz.to_s].compact.join('::').constantize
      end
    end
  end
end
