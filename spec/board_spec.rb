# frozen_string_literal: true

require_relative '../lib/board'

# Tests for the Connect Four Board class

describe Board do
  describe '#valid_move?' do
    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }

        it 'returns true for empty first column' do
          expect(empty_board.valid_move?).to be true
        end
        it 'returns false for invalid moves' do
          expect(empty_board.)
        end
      end
  end
end
