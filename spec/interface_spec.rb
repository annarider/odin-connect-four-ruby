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

  describe '.show_board' do
    context 'when the game starts and board is empty' do
      let(:empty_board) { instance_double(Board, board: Array.new(6) {
        Array.new(7, ' ')
      }) }
      it 'shows board without errors' do
        expect { Interface.show_board(empty_board) }.not_to raise_error
      end
    end
  end
end
