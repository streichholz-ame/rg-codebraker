module Codebraker
  include Validation

  RSpec.describe Game do
    subject(:game) { described_class.new(player, difficulty) }

    let(:player) { 'player' }
    let(:difficulty) { Constants::DIFFICULTIES.keys.sample }
    let(:difficulty_attempts) { Constants::DIFFICULTIES[difficulty][:attempts] }
    let(:secret_code) { '6543' }

    describe '#start' do
      let(:difficulty_hints) { Constants::DIFFICULTIES[difficulty][:hints] }

      it 'generates secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq(Codebraker::Constants::CODE_LENGTH)
      end

      it 'generates correct range' do
        expect(game.instance_variable_get(:@secret_code).join).to match(Codebraker::Validation::CODE_REGEX)
      end

      it 'has correct attempts number' do
        expect(game.instance_variable_get(:@attempts_total)).to eq(difficulty_attempts)
      end

      it 'has correct hints number' do
        expect(game.instance_variable_get(:@hints).length).to eq(difficulty_hints)
      end

      it 'has no attempts used' do
        expect(game.instance_variable_get(:@attempts_used)).to be_zero
      end
    end

    describe '#hint' do
      it 'returns number from code' do
        expect(game.instance_variable_get(:@secret_code)).to include(game.give_hint)
      end

      it 'changes hint size by 1' do
        expect { game.give_hint }.to change { game.instance_variable_get(:@hints).size }.by(-1)
      end

      it 'returns nil if hints empty' do
        game.instance_variable_set(:@hints, [])
        expect { game.give_hint }.to raise_error(HintError)
      end
    end

    describe '#comparing_answers' do
      before do
        game.instance_variable_set(:@secret_code, secret_code.chars)
      end

      describe 'checking codes' do
        [
          { answer: '++--', guess: '5643' },
          { answer: '+-', guess: '6411' },
          { answer: '+++', guess: '6544' },
          { answer: '----', guess: '3456' },
          { answer: '+', guess: '6666' },
          { answer: '-', guess: '2666' },
          { answer: '', guess: '2222' },
          { answer: '+---', guess: '4653' },
          { answer: '++-', guess: '6153' },
          { answer: '++++', guess: '6543' }
        ].each do |try|
          it 'returns result' do
            expect(CodeCheck.new(secret_code.chars, try[:guess]).check_numbers).to eq(try[:answer])
          end
        end
      end
    end

    describe '#start_game' do
      let(:wrong_guess) { '1234' }

      before do
        game.instance_variable_set(:@secret_code, secret_code.chars)
      end

      it 'attempts counter changes by 1' do
        expect { game.check_guess wrong_guess }.to change { game.instance_variable_get(:@attempts_used) }.by(1)
      end

      it 'changes status to win' do
        expect(game.check_guess(secret_code)[:status]).to eq(:win)
      end

      it 'changes status to lose' do
        game.instance_variable_set(:@attempts_used, difficulty_attempts.pred)
        expect(game.check_guess(wrong_guess)[:status]).to eq(:lost)
      end
    end
  end
end
