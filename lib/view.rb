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
end
