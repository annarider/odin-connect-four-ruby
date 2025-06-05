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
    return false unless column.between?(0, COLUMNS - 1)

    return false unless board[0][column].nil? # check top row

    true
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

  private

  def valid_position?(row, column)
    row.between?(0, ROWS - 1) && column.between?(0, COLUMNS - 1)
  end
end
