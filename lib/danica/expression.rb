module Danica
  class Expression
    include Common
    include DSL
    include BaseOperations
    include Expressable

    autoload :Gauss,    'danica/expression/gauss'

    delegate :to_f, :to, :is_grouped?, :priority, to: :expression_block

    built_with(:expression_block)

    def initialize(*args)
      options = args.extract_options!

      attributes = { variables: args.flatten }.merge(options)

      attributes.each do |key, value|
        self.public_send("#{key}=", value)
      end
    end
  end
end
