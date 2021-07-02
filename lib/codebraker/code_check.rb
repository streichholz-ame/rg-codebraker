module Codebraker
  class CodeCheck
    def initialize(secret_code, guess)
      @code = secret_code
      @player_guess = guess.chars
    end

    def check_numbers
      plus_count = Codebraker::Constants::EXACT_MATCH_SYMBOL * exact_match_count
      minus_count = Codebraker::Constants::MATCH_SYMBOL * match_count
      plus_count + minus_count
    end

    private

    def zip_code
      @player_guess.zip(@code)
    end

    def exact_match_count
      zip_code.count(&code_match)
    end

    def match_count
      filtered_code = zip_code.delete_if(&code_match)
      return 0 if filtered_code.empty?

      secret_code, player_guess = filtered_code.transpose

      player_guess.count do |guess_digit|
        position = secret_code.index(guess_digit)
        secret_code.delete_at(position) if position
      end
    end
    
    def code_match
      proc { |player_digit, secret_digit| player_digit == secret_digit }
    end
  end
end
