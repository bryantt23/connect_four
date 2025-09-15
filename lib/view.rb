class View
  def welcome
    puts 'Welcome to Connect Four!'
  end

  def show_board(grid)
    grid.each do |row|
      puts "#{row.join(' ')}"
    end
    puts "#{(1..7).to_a.join(' ')}"
  end

  def show_turn(player)
    puts "It's your turn #{player}. Select the column you want to drop your piece."
  end

  def invalid_column
    puts 'Invalid column. Please select a different column.'
  end

  def show_winner(winner)
    if winner == 'Tie'
      puts 'It is a tie.'
    else
      puts "#{winner} wins!"
    end
  end

  def play_again
    puts 'Press Enter to play again or E(x)it.'
  end

  def goodbye
    puts "Thanks for playing Connect Four"
  end
end
