class Danica::Format
  attr_reader :content, :format

  def initialize(content, format)
    @content = content
    @format = format
  end

  def to_s
    content.to(format)
  end
end
