module Codebraker
  module Errors
    class InvalidGuessError < Base
      def initialize
        super(I18n.t(:invalid_guess))
      end
    end
  end
end
