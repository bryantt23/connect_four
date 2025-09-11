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
end
