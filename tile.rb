class Tile
  attr_accessor :adjacent_bomb_count
  attr_reader :is_revealed, :is_bomb

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @is_revealed = false
    @is_flagged = false
    @adjacent_bomb_count = nil
  end

  def reveal
    @is_revealed = true
  end

  def to_s
    if @is_revealed
      @is_bomb ? "B" : @adjacent_bomb_count.to_s
    else
      @is_flagged ? "F" : "*"
    end
  end

  def toggle_flag
    @is_flagged = !@is_flagged
  end

end
