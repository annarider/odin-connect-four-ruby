# frozen_string_literal: true

require_relative '../lib/interface'

# Tests for the Connect Four Interface module

describe Interface do
  describe '.request_name' do
    context 'when the game setup establishes players' do
      it "accepts the player's name" do
        allow(Interface).to receive(:gets).and_return("Anna\n")
        expect { Interface.request_name }.to output("What's your name?\n").to_stdout
        expect(Interface.request_name).to eq('Anna')
      end
    end
  end
end
