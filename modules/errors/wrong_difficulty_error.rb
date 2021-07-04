module Codebraker
  module Errors
    class WrongDifficultyError < Base
      def initialize
        super(I18n.t(:wrong_difficulty))
      end
    end
  end
end
