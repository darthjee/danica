# frozen_string_literal: true

class Danica::Formatted
  attr_reader :content, :options

  def initialize(content, **options)
    @content = content
    @options = options
  end

  def to_s
    content.to(format, **options)
  end

  def ==(other)
    return false unless other.class == self.class

    other.content == content &&
      other.format == format
  end

  def format
    options[:format]
  end

  def repack(object)
    self.class.new(
      object,
      **options
    )
  end

  def to_tex(**)
    to(:tex, **)
  end

  def to_gnu(**)
    to(:gnu, **)
  end

  def to(format, **opts)
    content.to(format, **options.merge(opts))
  end

  private

  def method_missing(method, *)
    value = content.public_send(method, *)
    return value unless value.is_a?(Danica::Common)

    repack(value)
  end
end
