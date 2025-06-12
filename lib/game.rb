# frozen_string_literal: true

require_relative 'player'

# Game defines a game object
# in Connect Four, which handles
# game logic. It orchestrates
# creating board and player
# objects, switching player
# turns, checking for game over
# and win conditions, etc.
# 
# Game doesn't handle the 
# game loop. That's taken
# care of in the main
# execution.
#
# @example Create a new Game
# game = Game.new
#
class Game
  attr_accessor :players, :current_player_index

  def initialize
    @current_player_index = 0
  end
  
  def start
    Interface.welcome
    @players = Interface.greet_players
  end

  def current_player
    players[current_player_index]
  end

  def switch_turns
    if current_player_index == 0 
      @current_player_index = 1
    else
      @current_player_index = 0
    end
  end

  private
  
end
