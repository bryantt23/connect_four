require_relative 'grid'
require_relative 'view'

class GameEngine
  def initialize
    @grid = nil
    @view = View.new
    @current_player = nil
  end

  def start
    play_game
  end

  def play_game
    @grid = Grid.new
    @view.welcome
    @current_player = 'X'

    until @grid.game_over?
      @view.show_board(@grid.grid)
      player_move
      change_player
    end
    @view.show_winner(@grid.winner)

    play_again
  end

  def play_again
    loop do
      @view.play_again
      input = gets.chomp.downcase
      if input == ''
        play_game
      elsif input == 'x'
        @view.goodbye
        exit
      end
    end
  end

  private

  def change_player
    @current_player = if @current_player == 'X'
                        'O'
                      else
                        'X'
                      end
  end

  def player_move
    valid_move = false
    while valid_move == false
      @view.show_turn(@current_player)
      column = gets.chomp.to_i - 1
      valid_move = @grid.make_move(@current_player, column)
      @view.invalid_column if valid_move == false
    end
  end
end

g = GameEngine.new
g.start
