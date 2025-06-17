# frozen_string_literal: true

require_relative '../lib/board'

# Tests for the Connect Four Board class

describe Board do
  let(:empty_board) { described_class.new }
  let(:full_board) do
    board = described_class.new
    6.times { |row| 7.times { |column| board.grid[row][column] = 'p' } }
    board
  end
  let(:partially_full_board) do 
    board = described_class.new
    board.grid[bottom_row][0] = 'p' # add 1 piece
    bottom_row.downto(4) { |row| board.grid[row][1] = 'p' } # add 2 pieces
    bottom_row.downto(2) { |row| board.grid[row][2] = 'y' } # fill column
    board
  end
  let(:stalemate_board) do
    board = described_class.new
    board.grid = board.grid.map.with_index do |row, row_index|
      row.map.with_index do |column, column_index|
        (row_index + column_index).even? ? 'y' : 'p' 
      end
    end
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

    context 'when the board has a full second column and all other columns are empty' do

      let(:full_column_board) do 
        board = described_class.new 
        bottom_row.downto(0) { |row| board.grid[row][2] = 'y' }
        board
      end
      it 'returns true for adding another piece in first column' do
        expect(full_column_board.valid_move?(1)).to be true
      end
      it 'returns false for adding a piece in full column' do
        expect(full_column_board.valid_move?(2)).to be false
      end
    end
  end

  describe '#drop_piece' do
    context 'when the board is empty' do

      it 'places the piece at the bottom row' do
        expect { empty_board.drop_piece(0, 'p') }.to change { empty_board.grid[bottom_row][0] }.from(nil).to('p')
      end
    end
    context 'when the board is full' do

      it 'throws an error when adding another piece' do
        expect { full_board.drop_piece(0, 'p') }.to raise_error(ArgumentError)
      end
    end
    context 'when the column is partially full' do

      it 'stacks a game piece on top of an existing piece' do
        expect {partially_full_board.drop_piece(0, 'p') }.to change { partially_full_board.grid[bottom_row - 1][0] }.from(nil).to('p')
      end
    end
  end

  describe '#game_over?' do
    context 'scenarios where game_over? is true' do
      context 'when the board is full of X pieces (win in all directions)' do
        
        it 'returns true' do
          expect(full_board.game_over?(2)).to be true
        end
      end
      context 'when the board has a vertical win' do
        
        it 'returns true' do
          expect(partially_full_board.game_over?(2)).to be true
        end
      end
      context 'when the board has a horizontal win from bottom row, first column' do
        let(:board) { empty_board }
        before do
          4.times { |index| board.grid[bottom_row][index] = 'p' }
        end

        it 'returns true' do
          expect(board.game_over?(0)).to be true
        end
      end
      context 'when the board has a horizontal win from top row, last column' do
        let(:board) { empty_board }
        before do
          (1..4).each { |index| board.grid[top_row][index] = 'p' }
        end

        it 'returns true' do
          expect(board.game_over?(4)).to be true
        end
      end
      context 'when the board has a diagonal lower left win' do
        let(:board) { empty_board }
        before do
          (0..3).each { |index| board.grid[bottom_row - index][index] = 'y' }
        end

        it 'returns true' do
          expect(board.game_over?(2)).to be true
        end
      end
      context 'when the board has a diagonal lower right win' do
        let(:board) { empty_board }
        before do
          (0..3).each { |index| board.grid[2 + index][3 + index] = 'p' }
        end

        it 'returns true' do
          expect(board.game_over?(3)).to be true
        end
      end
      context 'when the board is full and a stalemate' do
        it 'returns true' do
          expect(stalemate_board.game_over?(0)).to be true
        end
      end
    end
    context 'scenarios where game_over? is false' do
      context 'when the board is empty' do

        it 'returns false' do
          expect(empty_board.game_over?(0)).to be false
        end
      end
      context 'when the board is partially full without a winner' do
        let(:no_winner_board) do
          no_winner_board = described_class.new
          no_winner_board.grid[bottom_row][0] = 'p'
          no_winner_board.grid[bottom_row][1] = 'y'
          no_winner_board.grid[bottom_row][2] = 'y'
          no_winner_board
        end

        it 'returns false' do
          expect(no_winner_board.game_over?(2)).to be false
        end
      end
    end
  end

    describe '#winner?' do
    context "when there's a winner" do
      it 'returns true in the public interface' do
        partially_full_board.grid[bottom_row] = ['p', 'p', 'p', 'p', nil, nil]
        expect(partially_full_board.winner?(3)).to be true
      end
    end
  end
end
