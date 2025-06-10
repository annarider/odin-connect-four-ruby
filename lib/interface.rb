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
end
