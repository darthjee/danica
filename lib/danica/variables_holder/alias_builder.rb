# frozen_string_literal: true

module Danica
  module VariablesHolder
    class AliasBuilder
      attr_reader :clazz, :origin, :destiny

      def initialize(origin, destiny, clazz)
        @origin = origin
        @destiny = destiny
        @clazz = clazz
      end

      def build
        clazz.variables_hash.change_keys! { |k| k == origin ? destiny : k }
        VariablesBuilder.new([destiny], clazz).build
        clazz.send(:alias_method, "#{origin}=", "#{destiny}=")
        clazz.send(:alias_method, origin, destiny)
      end
    end
  end
end
