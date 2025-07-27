# frozen_string_literal: true

module Danica
  module Wrapper
    class Container
      include Common
      attr_accessor :content

      delegate :to_f, :contentd?, :to, :to_tex, :to_gnu, :priority, :grouped?,
               :signaled?, :constant?, :valued?, :*, :+, :-, :/, :**, :-@,
               :variables, :variable?, to: :content

      default_value :container?, true

      def initialize(content)
        @content = content
      end

      def ==(other)
        return content == other unless other.is_a?(self.class)

        content == other.content
      end
    end
  end
end
