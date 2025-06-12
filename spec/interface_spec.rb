# frozen_string_literal: true

require_relative '../lib/interface'
require_relative '../lib/board'

# Tests for the Connect Four Interface module

describe Interface do
  describe '.greet_players' do
    context 'when game greets the players' do
      it "should request and return the players' names" do
        allow(Interface).to receive(:gets).and_return('Anna', 'Alex')
        expect(Interface.greet_players).to eq(['Anna', 'Alex'])
      end
    end
  end
  describe '.request_column' do
    context 'when the player chooses a column to drop a piece into' do
      context 'when the chosen column is between 0 and 6' do
        let(:valid_column) { '3' }

        before do
          allow(Interface).to receive(:gets).and_return(valid_column)
        end
        it 'returns the column number' do
          expect(Interface.request_column).to eq(2)
        end
      end
      context 'when the chosen column is invalid twice then valid' do
        let(:letter) { 'd' }
        let(:symbol) { '$' }
        let(:valid_input) { '6' }

        before do
          allow(Interface).to receive(:gets).and_return(letter, symbol, valid_input)
          allow(Interface).to receive(:puts)
        end

        it 'completes loop after two incorrect tries' do
          Interface.request_column
          expect(Interface).to have_received(:puts).with(/Invalid/).twice
          expect(Interface.request_column).to eq(5)
        end
      end
    end
  end
end
