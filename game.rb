class Game

  def initialize
    @board = Board.random_board
    puts "Welcome to Minesweeper!"
  end

  def play_turn
    system('clear')
    @board.render
    move = prompt
    make_guess(move)
  end

  def run
    play_turn until game_over?
    end_game
  end

  def make_guess(move)

  end

  def prompt
  end

  def game_over?
  end

  def end_game
  end

end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.run
end
