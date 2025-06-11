# frozen_string_literal: true

# Interface defines a game IO
# module in Connect Four.
# 
# It displays messages to the
# user and receives input for
# game play. It also verifies 
# and cleanses user input.
#
module Interface
  def self.request_name
    puts "What's your name?"
    name = gets.chomp
    name
  end

  def self.show_board(board)
    puts board
  end

  def self.request_column
    puts <<~MESSAGE
      🔮 Which column do you want drop a piece into?
      Pick from 1 to 7.
    MESSAGE
    column = gets.chomp.delete(' ').to_i
    valid_input?(column) ? (column - 1) : guess_again(column)
  end

  private

  def self.valid_input?(input)
    input.between?(1, 7)
  end

  def self.guess_again(input)
    puts '❌ Invalid column number.'
    request_column
  end
end
