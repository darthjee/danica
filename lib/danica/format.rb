class Danica::Format
  attr_reader :content, :format

  def initialize(content, format)
    @content = content
    @format = format
  end

  def to_s
    content.to(format)
  end

  def method_missing(method, *args)
    self.class.new(
      content.public_send(method, *args),
      format
    )
  end
end
