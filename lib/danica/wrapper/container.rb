module Danica
  class Wrapper::Container
    attr_accessor :content

    delegate :to_f, :contentd?, :to, :to_tex, :to_gnu, :priority, :grouped?,
             :signaled?, :constant?, :valued?, to: :content

    def initialize(content)
      @content = content
    end

    def ==(other)
      return content == other unless other.is_a?(self.class)
      content == other.content
    end
  end
end



