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
  def self.welcome
    puts <<~WELCOME
      🔴🔴🔴🔴 Welcome to Connect Four. You will pick a column to drop 
      game pieces into. The first person to reach 4 pieces-
      horizontally, vertically, or diagonally-in a row wins. 
    WELCOME
  end

  def self.greet_players  
    puts <<~GREET
      Let's start by creating players. We need 2 players.
      Let's start with Player 1.
    GREET
    player1 = request_name
    puts 'Next, Player 2.'
    player2 = request_name
    puts "Excellent. We have #{player1} and #{player2} ready."
    [player1, player2]
  end

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
