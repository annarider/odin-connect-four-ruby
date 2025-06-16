# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/interface'

# Tests for the Connect Four Game class

describe Game do
  let(:new_game) { Game.new }
  let(:running_game) do
    game = Game.new
    game.players = [Player.new('Anna', 'p'), Player.new('Alex', 'y')]
    game
  end

  describe '#start' do
    context 'when starting the game' do
      it 'it sends a welcome message and creates 2 players' do
        player_data = { 'Anna' => 'p', 'Alex' => 'y' }
        allow(Interface).to receive(:welcome)
        allow(Interface).to receive(:request_players_data).and_return(player_data)
        allow(Interface).to receive(:show)
        expect(Interface).to receive(:welcome).ordered
        expect(Interface).to receive(:request_players_data).ordered
        expect(Interface).to receive(:show).ordered
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

  describe '#play_turn' do
    context 'when the current player gets a turn' do
      it 'orchestrates a full turn' do
        allow(Interface).to receive(:announce_turn)
        column_input = 1
        allow(Interface).to receive(:request_column).and_return(column_input)
        allow(running_game.board).to receive(:drop_piece)
        allow(Interface).to receive(:show)
        allow(running_game).to receive(:switch_turns)

        running_game.play_turn

        expect(Interface).to have_received(:announce_turn).ordered
        expect(Interface).to have_received(:request_column).ordered
        expect(running_game.board).to have_received(:drop_piece).with(0, 'p').ordered
        expect(Interface).to have_received(:show).ordered
        expect(running_game).to have_received(:switch_turns).ordered
      end
    end
  end

  describe '#game_over?' do
    context 'when a new game starts' do
      it 'returns false' do
        expect(new_game.game_over?(0)).to be false
      end
    end
    context "when a running game doesn't meet game over conditions" do
      it 'returns false' do
        expect(running_game.game_over?(0)).to be false
      end
    end
    context 'when the board is full & a stalemate meeting game over' do
      before do
        allow(running_game.board).to receive(:game_over?).and_return(true)
      end
      it 'returns true' do
        expect(running_game.game_over?(0)).to be true
      end
      it 'announces game over and no winners' do
        expect { running_game.send(:announce_end) }.to output("Game over! Nobody won.\n").to_stdout
      end
    end
    context 'when there is a winner on the board' do
      before do 
        allow(running_game.board).to receive(:game_over?).and_return(true)
      end
      it 'returns true' do
        expect(running_game.game_over?(0)).to be true
      end
      it 'announces game over and the winner' do
        running_game.instance_variable_set(:@current_player, 'Anna')
        expect { running_game.send(:announce_winner, 'Anna') }.to output("Game over! Anna won.\n").to_stdout 
      end
    end
  end
end
