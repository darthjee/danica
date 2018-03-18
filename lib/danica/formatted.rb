class Danica::Formatted
  attr_reader :content, :format, :decimals

  def initialize(content, format, decimals: nil)
    @content = content
    @format = format
    @decimals = decimals
  end

  def to_s
    content.to(format, decimals: decimals)
  end

  def ==(other)
    return false unless other.class == self.class
    return other.content == content &&
           other.format == format
  end

  private

  def method_missing(method, *args)
    value = content.public_send(method, *args)
    return value unless value.is_a?(Danica::Common)
    self.class.new(
      value,
      format
    )
  end
end
