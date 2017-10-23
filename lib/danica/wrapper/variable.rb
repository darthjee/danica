module Danica
  class Wrapper::Variable
    include BaseOperations
    include Common

    attr_accessor :content, :name, :latex, :gnu
    delegate :value, to: :content, allow_nil: true

    default_value :variable?, true

    def initialize(attributes={})
      attributes.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end

    def to_f
      content.nil? ? raise(Exception::NotDefined) : content.to_f
    end

    def ==(other)
      return false unless other.class == self.class
      return other.content == content &&
             other.name == name &&
             other.latex == latex &&
             other.gnu == gnu
    end

    def priority
      content.try(:priority) || 10
    end

    def is_grouped?
      content.try(:is_grouped?) || false
    end

    def to_tex
      return content.to_tex if content
      (latex || name).to_s
    end

    def to_gnu
      return content.to_gnu if content
      (gnu || name).to_s
    end

    def value=(value)
      @content = value.nil? ? value : wrap_value(value)
    end

    def constant?
      content ? content.try(:constant?) : false
    end
  end
end

