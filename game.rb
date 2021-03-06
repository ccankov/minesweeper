require_relative 'board'

class Game

  def initialize(board = Board.random_board)
    @board = board
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
    type, pos = move
    if "fF".include?(type)
      @board.flag(pos)
    else
      @board.reveal(pos)
    end
  end

  def prompt
    puts "Please indicate your move. (f)lag/(r)eveal"
    type = gets.chomp
    until "fFrR".include?(type)
      puts "Invalid move, please enter a new move."
      type = gets.chomp
    end

    puts "Please indicate the tile position. eg: 0,0"
    pos = gets.chomp.split(',').map(&:to_i)
    until @board.valid_pos?(pos)
      puts "Invalid position, please enter a new position."
      pos = gets.chomp.split(',').map(&:to_i)
    end

    [type, pos]
  end

  def game_over?
    @board.game_over?
  end

  def end_game
    @board.render
    if @board.won?
      puts "Congratulations, you win!"
    else
      puts "BOOM! You lose :("
    end
  end

end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.run
end
