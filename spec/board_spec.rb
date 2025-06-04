# frozen_string_literal: true

require_relative '../lib/board'

# Tests for the Connect Four Board class

describe Board do
  it 'creates a new board' do
    board = Board.new
    expect(board).to be_a(Board)
  end

  describe '#valid_move?' do
    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }

        it 'returns true for dropping into first column' do
          expect(empty_board.valid_move?(0)).to be true
        end
        it 'returns false for invalid column -1' do
          expect(empty_board.valid_move?(-1)).to be false
        end
        it 'returns false for invalid column 10' do
          expect(empty_board.valid_move?(10)).to be false
        end
      end
  end
end
