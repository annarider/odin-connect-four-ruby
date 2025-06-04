# frozen_string_literal: true

require_relative '../lib/board'

# Tests for the Connect Four Board class

describe Board do
  let(:top_row) { 0 }
  let(:bottom_row) { 5 }
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
      it 'returns true for end column 6' do
        expect(empty_board.valid_move?(6)).to be true
      end
      it 'returns false for invalid column -1' do
        expect(empty_board.valid_move?(-1)).to be false
      end
      it 'returns false for invalid column 10' do
        expect(empty_board.valid_move?(10)).to be false
      end
      it 'returns false for invalid column 7' do
        expect(empty_board.valid_move?(7)).to be false
      end
    end

    context 'when the board is full' do
      subject(:full_board) { described_class.new }

      before do
        board = full_board.instance_variable_get(:@board)
        6.times { |row| board[row][0] = 'X' }
      end

      it 'returns false for adding another piece' do
        expect(full_board.valid_move?(0)).to be false
      end
    end

    context 'when the board is partially full' do
      subject(:partially_full_board) { described_class.new }

      before do
        board = partially_full_board.instance_variable_get(:@board)
        bottom_row.downto(3) { |row| board[row][0] = %w[X O].sample }
        bottom_row.downto(4) { |row| board[row][1] = %w[X O].sample }
        bottom_row.downto(1) { |row| board[row][2] = %w[X O].sample }
        bottom_row.downto(2) { |row| board[row][3] = %w[X O].sample }
        bottom_row.downto(4) { |row| board[row][4] = %w[X O].sample }
        bottom_row.downto(0) { |row| board[row][5] = %w[X O].sample }
        bottom_row.downto(4) { |row| board[row][6] = %w[X O].sample }
      end

      it 'returns true for adding another piece in first column' do
        expect(partially_full_board.valid_move?(1)).to be true
      end
      it 'returns false for adding a piece in full column' do
        expect(partially_full_board.valid_move?(5)).to be false
      end
    end
  end

  describe '#drop_piece' do
    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }

      it 'places the piece at the bottom row' do
        expect(empty_board.drop_piece(0, 'X')).to change { empty_board.board[0][0] }.from(nil).to('X')
      end
    end
  end
end
