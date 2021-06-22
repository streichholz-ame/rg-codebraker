module Codebraker
  module Constants
    EXACT_MATCH_SYMBOL = '+'.freeze
    MATCH_SYMBOL = '-'.freeze
    CODE_LENGTH = 4
    WIN_MATCH = EXACT_MATCH_SYMBOL * CODE_LENGTH
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hard: { attempts: 5, hints: 1 }
                   .freeze
    }.freeze
  end
end
