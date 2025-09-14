class Grid
  attr_accessor :grid

  def initialize
    @grid = Array.new(6) do
      Array.new(7, '_')
    end
  end

  def game_over?
    winner != nil
  end

  def make_move(symbol, column)
    if column < 0 || column >= @grid[0].length || @grid[0][column] != '_'
      false
    else
      row = @grid.length - 1
      row -= 1 while @grid[row][column] != '_'
      @grid[row][column] = symbol
      true
    end
  end

  def winner
    row_winner = check_row(@grid)
    return row_winner unless row_winner.nil?

    col_winner = check_col
    return col_winner unless col_winner.nil?

    diagonal_winner_down_left = check_diagonal_down_left
    return diagonal_winner_down_left unless diagonal_winner_down_left.nil?

    diagonal_winner_down_right = check_diagonal_down_right
    return diagonal_winner_down_right unless diagonal_winner_down_right.nil?

    @grid.each do |row|
      return nil if row.any? { |elem| elem == '_' }
    end

    'Tie'
  end

  private

  def check_diagonal_down_right
    i = 0
    while i < @grid.length
      diagonal = check_diagonal_helper_down_right(i, 0)
      return diagonal unless diagonal.nil?

      i += 1
    end

    j = 0
    while j < @grid[0].length
      diagonal = check_diagonal_helper_down_right(0, j)
      return diagonal unless diagonal.nil?

      j += 1
    end
  end

  def check_diagonal_helper_down_right(row, col)
    ct = 0
    while row < @grid.length && col < @grid[0].length
      elem = @grid[row][col]
      if elem == 'X'
        if ct > 0
          ct += 1
          return 'X' if ct == 4
        else
          ct = 1
        end
      elsif elem == 'O'
        if ct < 0
          ct -= 1
          return 'O' if ct == -4
        else
          ct = -1
        end
      else
        ct = 0
      end
      row += 1
      col += 1
    end
  end

  def check_diagonal_down_left
    i = 0
    while i < @grid.length
      diagonal = check_diagonal_helper_down_left(i, @grid[0].length - 1)
      return diagonal unless diagonal.nil?

      i += 1
    end

    j = 0
    while j < @grid[0].length
      diagonal = check_diagonal_helper_down_left(0, j)
      return diagonal unless diagonal.nil?

      j += 1
    end
  end

  def check_diagonal_helper_down_left(row, col)
    ct = 0
    while row < @grid.length && col >= 0
      elem = @grid[row][col]
      if elem == 'X'
        if ct > 0
          ct += 1
          return 'X' if ct == 4
        else
          ct = 1
        end
      elsif elem == 'O'
        if ct < 0
          ct -= 1
          return 'O' if ct == -4
        else
          ct = -1
        end
      else
        ct = 0
      end
      row += 1
      col -= 1
    end
  end

  def check_col
    transposed_matrix = @grid.transpose
    check_row(transposed_matrix)
  end

  def check_row(grid)
    # check each row
    grid.each do |row|
      ct = 0
      row.each do |elem|
        if elem == 'X'
          if ct > 0
            ct += 1
            return 'X' if ct == 4
          else
            ct = 1
          end
        elsif elem == 'O'
          if ct < 0
            ct -= 1
            return 'O' if ct == -4
          else
            ct = -1
          end
        else
          ct = 0
        end
      end
    end
    nil
  end
end
