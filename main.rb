# frozen_string_literal: true

# main contains the main execution
# for running a Connect Four game

require_relative 'lib/game'

loop do
  game = Game.new
  game.start
  loop do
    game.play_turn
    break if game.end_game?
  end
  puts 'Play again? Enter y for yes (y): '
  break unless gets.chomp.downcase == 'y'
end
