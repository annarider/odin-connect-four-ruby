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
  COLORS = 'rbyp'

  def self.welcome
    puts <<~WELCOME
      🔴🔴🔴🔴 Welcome to Connect Four. You will pick a column to drop#{' '}
      game pieces into. The first person to reach 4 pieces-
      horizontally, vertically, or diagonally-in a row wins.
      Pick a column to drop a piece into from 1 to 7.
    WELCOME
  end

  def self.request_players_data
    puts "Let's start by creating players. We need 2 players."
    puts "Let's start with Player 1."
    player1_name = request_name
    player1_symbol = request_symbol
    puts 'Next, Player 2.'
    player2_name = request_name
    player2_symbol = request_symbol
    puts "Excellent. We have #{player1_name} and #{player2_name} ready."
    { player1_name => player1_symbol, player2_name => player2_symbol }
  end

  def self.show(grid)
    grid.each do |row|
      puts "| #{row.map { |cell| cell.nil? ? '  ' : map_color(cell) }.join(' ')} |"
    end
  end

  def self.announce_turn(name)
    puts "#{name}, it's your turn."
  end

  def self.request_column
    puts <<~MESSAGE
      🔮 Which column do you want drop a piece into?
    MESSAGE
    column = gets.chomp.delete(' ').to_i
    valid_column?(column) ? column : request_column_again
  end

  def self.request_column_again
    puts '❌ Invalid column number.'
    request_column
  end

  def self.request_name
    puts "What's your name?"
    gets.chomp
  end

  def self.valid_column?(input)
    input.between?(1, 7)
  end

  def self.request_symbol
    puts 'What color do you want? 🔴 🔵 🟡 🟣'
    puts "Type #{COLORS.split.join('  ')}"
    symbol = gets.chomp.delete(' ')
    valid_color?(symbol) ? symbol : request_color_again
  end

  def self.valid_color?(symbol)
    return false unless symbol.length == 1

    COLORS.include?(symbol)
  end

  def self.map_color(symbol)
    case symbol
    when 'r'
      '🔴'
    when 'b'
      '🔵'
    when 'y'
      '🟡'
    else
      '🟣'
    end
  end

  def self.request_color_again
    puts '❌ Invalid symbol color.'
    request_symbol
  end
end
