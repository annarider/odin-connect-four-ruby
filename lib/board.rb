# frozen_string_literal: true

# Board defines a game board
# in Connect Four.
# 
# It manages the state and rules 
# of the game, such as tracking
# the position of the game pieces,
# checking for game over conditions,
# and validating moves.
#
# @example Create a new Board
# board = Board.new
#
class Board
  attr_accessor :board
  ROWS = 6
  COLUMNS = 7

  def initialize(rows = ROWS, columns = COLUMNS)
    @board = Array.new(rows) { Array.new(columns) }
  end

  def valid_move?(column)
    valid_column?(column) && board[0][column].nil? # check top row
  end

  def drop_piece(column, symbol)
    raise ArgumentError, 'Invalid move' unless valid_move?(column)
    (ROWS - 1).downto(0) do |row|
      if board[row][column].nil?
        board[row][column] = symbol 
        return
      end
    end
  end

  def piece_at(row, column)
    raise ArgumentError, 'Invalid position' unless valid_position?(row, column)
    board[row][column]
  end

  def game_over?
    winner? || full?
  end

  private

  def valid_column?(column)
    column.between?(0, COLUMNS - 1)
  end

  def valid_position?(row, column)
    valid_row?(row) && valid_column?(column) 
  end

  def valid_row?(row)
    row.between?(0, ROWS - 1)
  end

  def winner?
    false
  end

  def full?
    board.all? { |row| row.none?(&:nil?) }
  end
end
