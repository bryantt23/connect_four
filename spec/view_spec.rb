# spec/view_spec.rb
require 'spec_helper'
require_relative '../lib/view'

RSpec.describe View do
  let(:view) { View.new }

  describe '#welcome' do
    it 'prints the welcome message' do
      expect { view.welcome }.to output("Welcome to Connect Four!\n").to_stdout
    end
  end

  describe '#show_board' do
    it 'prints a 6x7 grid with column numbers' do
      grid = Array.new(6) { Array.new(7, '_') }
      expected_output = <<~BOARD
        _ _ _ _ _ _ _
        _ _ _ _ _ _ _
        _ _ _ _ _ _ _
        _ _ _ _ _ _ _
        _ _ _ _ _ _ _
        _ _ _ _ _ _ _
        1 2 3 4 5 6 7
      BOARD
      expect { view.show_board(grid) }.to output(expected_output).to_stdout
    end
  end

  describe '#show_turn' do
    it 'prints the current player turn' do
      expect do
        view.show_turn('X')
      end.to output("It's your turn X. Select the column you want to drop your piece.\n").to_stdout
    end
  end

  describe '#invalid_column' do
    xit 'prints an invalid column message' do
      expect { view.invalid_column }.to output("Invalid column. Please select a different column.\n").to_stdout
    end
  end

  describe '#show_winner' do
    xit 'prints X wins message' do
      expect { view.show_winner('X') }.to output("X wins!\n").to_stdout
    end

    xit 'prints O wins message' do
      expect { view.show_winner('O') }.to output("O wins!\n").to_stdout
    end

    xit 'prints tie message' do
      expect { view.show_winner('Tie') }.to output("It is a tie.\n").to_stdout
    end
  end

  describe '#play_again' do
    xit 'prints the play again prompt' do
      expect { view.play_again }.to output("Press Enter to play again or E(x)it.\n").to_stdout
    end
  end
end
