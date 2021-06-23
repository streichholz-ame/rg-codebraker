module Codebraker
  module Errors
    class EmptyStringError < Base
      def initialize
        super(I18n.t(:empty_string))
      end
    end
  end
end
