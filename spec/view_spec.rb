# spec/view_spec.rb
require 'spec_helper'
require_relative '../lib/view'

RSpec.describe View do
  describe '#welcome' do
    it 'prints the welcome message' do
      view = View.new
      expect { view.welcome }.to output("Welcome to Connect Four!\n").to_stdout
    end
  end

  describe '#show_board' do
    it 'prints a 6x7 grid with column numbers' do
      view = View.new
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
end
