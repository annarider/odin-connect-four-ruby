# frozen_string_literal: true

require_relative 'board'
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
  attr_accessor :players, :current_player_index, :board

  def initialize
    @players = []
    @current_player_index = 0
    @board = Board.new
  end
  
  def start
    Interface.welcome
    create_players(Interface.request_players_data)
    Interface.show(board.grid)
  end

  def current_player
    @players[current_player_index]
  end

  def play_turn
    current_player = players[current_player_index] 
    Interface.announce_turn(current_player.name)
    column = choose_column
    board.drop_piece(column, current_player.symbol)
    Interface.show(board.grid)
    switch_turns
  end

  def switch_turns
    if current_player_index == 0 
      @current_player_index = 1
    else
      @current_player_index = 0
    end
  end

  private
  
  def create_players(players_data)
    players_data.each do |name, symbol|
      @players << Player.new(name, symbol)
    end
  end
  
  def choose_column
    column_input = Interface.request_column
    column_input - 1 # convert to 0-based array
  end

  def check_game_over
    
  end
end
