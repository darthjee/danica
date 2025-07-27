# frozen_string_literal: true

module Danica::VariablesHolder
  class AliasBuilder
    attr_reader :clazz, :origin, :destiny

    def initialize(origin, destiny, clazz)
      @origin = origin
      @destiny = destiny
      @clazz = clazz
    end

    def build
      change_keys
      add_methods
      add_aliases
    end

    private

    def change_keys
      clazz.variables_hash.change_keys! { |k| k == origin ? destiny : k }
    end

    def add_methods
      VariablesBuilder.new(clazz, [destiny]).build
    end

    def add_aliases
      clazz.send(:alias_method, "#{origin}=", "#{destiny}=")
      clazz.send(:alias_method, origin, destiny)
    end
  end
end
