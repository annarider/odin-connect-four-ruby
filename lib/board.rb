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
    @board = Array.new(rows) { Array.new(columns)}
  end

  def valid_move?(column)
    true
  end
end
