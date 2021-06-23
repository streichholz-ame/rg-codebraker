module Codebraker
  module Errors
    class WrongEntityError < Base
      def initialize
        super(I18n.t(:wrong_entity))
      end
    end
  end
end
