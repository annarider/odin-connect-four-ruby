# frozen_string_literal: true

require_relative '../lib/interface'
require_relative '../lib/board'

# Tests for the Connect Four Interface module

describe Interface do
  describe '.request_name' do
    context 'when the game setup establishes players' do
      it "accepts and returns the player's name" do
        allow(Interface).to receive(:gets).and_return("Anna\n")
        expect { Interface.request_name }.to output("What's your name?\n").to_stdout
        expect(Interface.request_name).to eq('Anna')
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
