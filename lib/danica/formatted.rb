class Danica::Formatted
  attr_reader :content, :options

  def initialize(content, format, **options)
    @content = content
    @options = options.merge(format: format)
  end

  def to_s
    content.to(format, options)
  end

  def ==(other)
    return false unless other.class == self.class
    return other.content == content &&
           other.format == format
  end

  def format
    options[:format]
  end

  def repack(object)
    self.class.new(
      object,
      format,
      options
    )
  end

  private

  def method_missing(method, *args)
    value = content.public_send(method, *args)
    return value unless value.is_a?(Danica::Common)
    repack(value)
  end
end
