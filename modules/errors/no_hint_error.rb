module Codebraker
  module Errors
    class HintError < Base
      def initialize
        super(I18n.t(:no_hint_message))
      end
    end
  end
end
