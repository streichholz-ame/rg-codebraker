module Codebraker
  module Validation
    include Errors

    MIN_NAME_LENGTH = 3
    MAX_NAME_LENGTH = 20
    VALID_NAME_REGEX = /^[a-zA-Z]{#{MIN_NAME_LENGTH},#{MAX_NAME_LENGTH}}$/.freeze
    CODE_MIN = 1
    CODE_MAX = 6
    CODE_NUMS = (CODE_MIN..CODE_MAX).freeze
    CODE_REGEX = /^[#{CODE_MIN}-#{CODE_MAX}]{#{Constants::CODE_LENGTH}}$/.freeze

    def check_entity!(value)
      raise WrongEntityError unless value.is_a? String
    end

    def check_presence!(value)
      raise EmptyStringError if value.strip.empty?
    end

    def player_name_validate!(player_name)
      raise WrongNameError unless player_name.match?(VALID_NAME_REGEX)
    end

    def difficulty_validate!(difficulty)
      raise WrongDifficultyError unless Constants::DIFFICULTIES.key?(difficulty.to_sym)
    end

    def guess_validate!(value)
      raise InvalidGuessError unless value.match?(CODE_REGEX)
    end

    def hint_validate!(value)
      raise HintError if value.empty?
    end
  end
end
