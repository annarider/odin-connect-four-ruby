# frozen_string_literal: true

require_relative '../lib/interface'

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
      it 'shows board without errors' do
        board = double('board')
        expect {Interface.show_board(board) }.not_to raise_error
      end
    end
  end
end
