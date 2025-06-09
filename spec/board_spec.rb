# frozen_string_literal: true

require_relative '../lib/board'

# Tests for the Connect Four Board class

describe Board do
  let(:empty_board) { described_class.new }
  let(:full_board) do
    board = described_class.new
    6.times { |row| 7.times { |column| board.board[row][column] = 'X' } }
    board
  end
  let(:partially_full_board) do 
    board = described_class.new
    board.board[bottom_row][0] = 'X' # add 1 piece
    bottom_row.downto(4) { |row| board.board[row][1] = 'X' } # add 2 pieces
    bottom_row.downto(0) { |row| board.board[row][2] = 'O' } # fill column
    board
  end
  let(:top_row) { 0 }
  let(:bottom_row) { 5 }

  it 'creates a new board' do
    board = Board.new
    expect(board).to be_a(Board)
  end

  describe '#valid_move?' do
    context 'when the board is empty' do

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

      it 'returns false for adding another piece' do
        expect(full_board.valid_move?(0)).to be false
      end
    end

    context 'when the board is partially full' do

      it 'returns true for adding another piece in first column' do
        expect(partially_full_board.valid_move?(1)).to be true
      end
      it 'returns false for adding a piece in full column' do
        expect(partially_full_board.valid_move?(2)).to be false
      end
    end
  end

  describe '#drop_piece' do
    context 'when the board is empty' do

      it 'places the piece at the bottom row' do
        expect { empty_board.drop_piece(0, 'X') }.to change { empty_board.board[bottom_row][0] }.from(nil).to('X')
      end
    end
    context 'when the board is full' do

      it 'throws an error when adding another piece' do
        expect { full_board.drop_piece(0, 'X') }.to raise_error(ArgumentError)
      end
    end
    context 'when the column is partially full' do

      it 'stacks a game piece on top of an existing piece' do
        expect {partially_full_board.drop_piece(0, 'X') }.to change { partially_full_board.board[bottom_row - 1][0] }.from(nil).to('X')
      end
    end
  end

  describe '#piece_at' do
    context 'when the board is empty' do
      
      it "returns nil because there's no piece" do
        result = empty_board.piece_at(0, 0)
        expect(result).to be_nil
      end
    end
    context 'when the board is full of X pieces' do
      
      it 'returns the piece X' do
        result = full_board.piece_at(0, 0) do
        expect(result).to eq('X')
        end
      end
    end
    context 'when the board is partially full with X and O pieces' do
      
      it 'returns O when looking at a position with an O piece' do
        expect(partially_full_board.piece_at(5, 2)).to eq('O')
      end
    end
    context 'when the position is invalid' do
      
      it 'raises an error' do
        expect { empty_board.piece_at(-1, 0) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#game_over?' do
    context 'when the board is empty' do
      
      it 'returns false' do
        expect(empty_board.game_over?(bottom_row, 0)).to be false
      end
    end
    context 'when the board is full of X pieces (win in all directions)' do
      
      it 'returns true' do
        expect(full_board.game_over?(top_row, 2)).to be true
      end
    end
    context 'when the board has a vertical win' do
      
      it 'returns true' do
        expect(partially_full_board.game_over?(top_row, 2)).to be true
      end
    end
    context 'when the board has a horizontal win' do
      let(:board) { empty_board }
      before do
        4.times { |index| board.board[bottom_row][index] = 'X' }
      end

      it 'returns true' do
        expect(board.game_over?(bottom_row, 0)).to be true
      end
    end

  end
end
