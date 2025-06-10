# frozen_string_literal: true

# Player defines a player role
# in the Connect Four game.
# 
# It contains the player's
# name and symbol used in the
# board of the game.
#
# @example Create a new Player
# player1 = Player.new
#
class Player
  attr_accessor :name, :symbol

  def initialize(name, symbol = nil)
    @name = name
    @symbol = symbol
  end
end
