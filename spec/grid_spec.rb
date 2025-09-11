# spec/grid_spec.rb
require 'spec_helper'
require_relative '../lib/grid'

RSpec.describe Grid do
  let(:grid) { Grid.new }

  describe '#make_move' do
    it 'places X in the bottom row of an empty column' do
      grid.make_move('X', 0)
      expect(grid.grid[5][0]).to eq('X')
    end

    it 'stacks O on top of X in the same column' do
      grid.make_move('X', 0)
      grid.make_move('O', 0)
      expect(grid.grid[4][0]).to eq('O')
    end

    it 'places X in the bottom row of a different column' do
      grid.make_move('X', 1)
      expect(grid.grid[5][1]).to eq('X')
    end

    it 'returns false when trying to place in a full column' do
      6.times { grid.make_move('X', 0) }
      result = grid.make_move('O', 0)
      expect(result).to be false
    end

    it 'does not change state when column is full' do
      6.times { grid.make_move('X', 0) }
      snapshot = Marshal.load(Marshal.dump(grid.grid))
      grid.make_move('O', 0)
      expect(grid.grid).to eq(snapshot)
    end

    it 'returns false when column index is too low' do
      result = grid.make_move('X', -1)
      expect(result).to be false
    end

    it 'returns false when column index is too high' do
      result = grid.make_move('X', 7)
      expect(result).to be false
    end

    it 'does not change state when column index is invalid' do
      snapshot = Marshal.load(Marshal.dump(grid.grid))
      grid.make_move('X', 7)
      expect(grid.grid).to eq(snapshot)
    end
  end

  describe '#winner' do
    it 'returns nil on an empty board' do
      expect(grid.winner).to be_nil
    end

    it 'returns nil when the game is ongoing with no winner' do
      grid.make_move('X', 0)
      grid.make_move('O', 1)
      grid.make_move('X', 2)
      expect(grid.winner).to be_nil
    end

    it 'returns nil when only 3 in a row horizontally' do
      3.times { |i| grid.make_move('X', i) }
      expect(grid.winner).to be_nil
    end

    it 'detects vertical win for X' do
      4.times { grid.make_move('X', 0) }
      expect(grid.winner).to eq('X')
    end

    it 'detects horizontal win for O' do
      4.times { |i| grid.make_move('O', i) }
      expect(grid.winner).to eq('O')
    end

    it 'detects diagonal down left win for X' do
      # \
      # row 2: . . . X
      # row 3: . . X .
      # row 4: . X . .
      # row 5: X . . .
      grid.make_move('X', 0)

      grid.make_move('O', 1)
      grid.make_move('X', 1)

      2.times { grid.make_move('O', 2) }
      grid.make_move('X', 2)

      3.times { grid.make_move('O', 3) }
      grid.make_move('X', 3)

      expect(grid.winner).to eq('X')
    end

    it 'detects diagonal / win for X' do
      # Expected board (row 5 is bottom):
      # row 2: X
      # row 3: O X
      # row 4: O O X
      # row 5: O O O X
      # Column 3: just X at row 5
      grid.make_move('X', 3)

      # Column 2: one O filler at row 5, then X at row 4
      grid.make_move('O', 2)
      grid.make_move('X', 2)

      # Column 1: two O fillers at rows 5 & 4, then X at row 3
      2.times { grid.make_move('O', 1) }
      grid.make_move('X', 1)

      # Column 0: three O fillers at rows 5, 4, 3, then X at row 2
      3.times { grid.make_move('O', 0) }
      grid.make_move('X', 0)

      expect(grid.winner).to eq('X')
    end

    it 'returns Tie when board is full and no winner' do
      # Fill column by column from bottom (row 5) to top (row 0)
      pattern = {
        0 => %w[O X O X O X],
        1 => %w[X O X O X O],
        2 => %w[X O X O X O],
        3 => %w[O X O X O X],
        4 => %w[X O X O X O],
        5 => %w[X O X O X O],
        6 => %w[O X O X O X]
      }

      pattern.each do |col, pieces|
        pieces.each { |piece| grid.make_move(piece, col) }
      end

      expect(grid.winner).to eq('Tie')
    end
  end

  describe '#game_over?' do
    it 'returns false when winner is nil' do
      expect(grid.game_over?).to be false
    end

    it 'returns true when X wins' do
      4.times { grid.make_move('X', 0) }
      expect(grid.game_over?).to be true
    end

    it "returns true when it's a tie" do
      (0..5).each do |row|
        (0..6).each do |col|
          grid.make_move((row + col).even? ? 'X' : 'O', col)
        end
      end
      expect(grid.game_over?).to be true
    end
  end
end
