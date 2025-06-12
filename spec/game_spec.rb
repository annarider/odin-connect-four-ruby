# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/interface'

# Tests for the Connect Four Game class

describe Game do
  let(:new_game) { Game.new }
  let(:running_game) do 
    game = Game.new
    game.players = [Player.new('Anna', '🟣'), Player.new('Alex', '🟡')]
    game
  end

  describe '#start' do
    context 'when starting the game' do
      it 'it sends a welcome message and creates 2 players' do
        player_data = {'Anna' => '🟣', 'Alex' => '🟡'}
        allow(Interface).to receive(:welcome)
        allow(Interface).to receive(:request_players_data).and_return(player_data)
        expect(Interface).to receive(:welcome).ordered
        expect(Interface).to receive(:request_players_data).ordered
        new_game.start
      end
    end
  end
  describe '#current_player' do
    context 'when the game starts' do
      it 'returns the current player object' do
        expect(running_game.current_player).to be_a(Player)
      end
    end
  end  
  describe '#switch_turns' do
    context 'when the current player ends a turn' do
      it 'switches to the next player' do
        current_player = running_game.current_player
        running_game.switch_turns
        next_player = running_game.current_player
        expect(current_player).not_to eq(next_player)
      end
    end 
  end
end
