module Codebraker
  module Errors
    class WrongNameError < Base
      def initialize
        super(I18n.t(:wrong_name))
      end
    end
  end
end
