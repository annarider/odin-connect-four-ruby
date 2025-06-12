# frozen_string_literal: true

require_relative '../lib/game'

# Tests for the Connect Four Game class

describe Game do
  describe '#current_player' do
    context 'when the game starts' do
      let(:start_game) { Game.new }
      it "returns the current player object" do
        expect(start_game.current_player).to be_a(Player)
      end
    end
  end
end
