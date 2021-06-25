module Codebraker
  class Game
    include Validation
    include Constants

    attr_reader :attempts_used, :hints_used, :status, :secret_code

    def initialize(player_name, difficulty)
      @player_name = player_name
      @difficulty = difficulty
      validate_data(player_name, difficulty)
      @attempts_used = 0
      @secret_code ||= Array.new(Constants::CODE_LENGTH) { rand(Validation::CODE_NUMS) }.map(&:to_s)
      @time_start = DateTime.now
      @attempts_total ||= Constants::DIFFICULTIES[@difficulty][:attempts]
      @hints_total ||= Constants::DIFFICULTIES[@difficulty][:hints]
      @hints = secret_code.sample(@hints_total)
    end

    def validate_data(player_name, difficulty)
      player_name_validate!(player_name)
      difficulty_validate!(difficulty)
    end

    def give_hint
      hint_validate!(@hints)
      @hints.pop
    end

    def check_guess(guess)
      check_input(guess)
      @attempts_used += 1
      answer = CodeCheck.new(secret_code, guess).check_numbers
      return { answer: answer, status: :win, code: @secret_code } if win?(answer)
      return { answer: answer, status: :lost, code: @secret_code } if lost?

      { answer: answer, status: :next }
    end

    def win?(answer)
      answer == Constants::WIN_MATCH
    end

    def lost?
      @attempts_total == @attempts_used
    end

    def check_input(player_code)
      check_entity!(player_code)
      check_presence!(player_code)
      guess_validate!(player_code)
    end

    def to_h
      {
        name: @player_name,
        difficulty: @difficulty,
        attempts: @attempts_total,
        attempts_left: @attempts_total - @attempts_used,
        hints: @hints_total,
        hints_left: @hints.size,
        started_at: @time_start
      }
    end
  end
end
