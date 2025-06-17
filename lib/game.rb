# frozen_string_literal: true

require_relative 'board'
require_relative 'interface'
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

  def play
    loop do
      column = play_turn
      if end_game?(column)
        handle_game_end(column, current_player.name)
        break
      else
        switch_turns
      end
    end
  end

  def play_turn
    current_player = players[current_player_index]
    Interface.announce_turn(current_player.name)
    column = pick_column
    board.drop_piece(column, current_player.symbol)
    Interface.show(board.grid)
    column
  end

  def pick_column
    column = nil
    loop do
      column = Interface.request_column
      break if board.valid_move?(column)
      Interface.request_column_again
    end
    column - 1 # convert to 0-based array
  end



  def end_game?(column)
    board.game_over?(column)
  end

  def switch_turns
    @current_player_index = if current_player_index.zero?
                              1
                            else
                              0
                            end
  end

  private

  def create_players(players_data)
    players_data.each do |name, symbol|
      @players << Player.new(name, symbol)
    end
  end

  def handle_game_end(column, name)
    if board.winner?(column)
      announce_winner(name)
    else
      announce_end
    end
  end

  def announce_winner(name)
    puts "Game over! #{name} won."
  end

  def announce_end
    puts 'Game over! Nobody won.'
  end
end
