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
  attr_accessor :grid

  ROWS = 6
  COLUMNS = 7

  def initialize(rows = ROWS, columns = COLUMNS)
    @grid = Array.new(rows) { Array.new(columns) }
  end

  def valid_move?(column)
    valid_column?(column) && grid[0][column].nil? # check top row
  end

  def drop_piece(column, symbol)
    raise ArgumentError, 'Invalid move' unless valid_move?(column)

    (ROWS - 1).downto(0) do |row|
      if grid[row][column].nil?
        grid[row][column] = symbol
        break
      end
    end
  end

  def game_over?(column)
    winner?(column) || full?
  end

  def winner?(column)
    row = find_highest_piece_row(column)
    return false unless row && valid_row?(row)

    piece = grid[row][column]
    return false if piece.nil?

    check_win_conditions(row, column, piece)
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

  def check_win_conditions(row, column, piece)
    horizontal_win?(row, column, piece) ||
      vertical_win?(row, column, piece) ||
      diagonal_left_down_win?(row, column, piece) ||
      diagonal_right_down_win?(row, column, piece)
  end

  def full?
    grid.all? { |row| row.none?(&:nil?) }
  end

  def find_highest_piece_row(column)
    grid.each_with_index do |row, row_index|
      return row_index unless row[column].nil?
    end
    nil
  end

  def empty_column?(column)
    grid.each do |row|
      row.each_with_index { |cell, index| !cell.nil? && index == column }
    end
  end

  def horizontal_win?(row, column, piece)
    line = build_line(row, column, 0, 1)
    four_in_a_row?(line, piece)
  end

  def vertical_win?(row, column, piece)
    line = build_line(row, column, 1, 0)
    four_in_a_row?(line, piece)
  end

  def diagonal_left_down_win?(row, column, piece)
    line = build_line(row, column, -1, 1)
    four_in_a_row?(line, piece)
  end

  def diagonal_right_down_win?(row, column, piece)
    line = build_line(row, column, 1, 1)
    four_in_a_row?(line, piece)
  end

  def build_line(row, column, row_delta, column_delta)
    (-3..3).map do |index|
      transformed_row = row + (index * row_delta)
      transformed_column = column + (index * column_delta)
      valid_position?(transformed_row, transformed_column) ? grid[transformed_row][transformed_column] : nil
    end
  end

  def four_in_a_row?(line, piece)
    line.each_cons(4).any? { |combo| combo.all? { |symbol| symbol == piece } }
  end
end
