class Grid
  attr_accessor :grid

  def initialize
    @grid = Array.new(6) do
      Array.new(7, '_')
    end
  end

  def make_move(symbol, column)
    if column < 0 || column >= @grid[0].length || @grid[0][column] != '_'
      false
    else
      row = @grid.length - 1
      row -= 1 while @grid[row][column] != '_'
      @grid[row][column] = symbol
    end
  end
end
