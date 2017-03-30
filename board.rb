require_relative "tile"

class Board

  ADJACENCY_DELTAS = [[-1, 0], [1, 0], [0, -1], [0, 1],
                      [1, 1], [-1, -1], [-1, 1], [1, -1]].freeze

  def self.random_board
    grid = Array.new(9) { Array.new(9) }

    bomb_locations = generate_bomb_pos(grid)

    grid = populate_grid(grid, bomb_locations)

    self.new(grid)
  end

  def self.generate_bomb_pos(grid)
    locations = []
    num_tiles = grid.length * grid[0].length
    num_bombs = num_tiles / 4

    until locations.length == num_bombs
      location = [rand(0...grid.length), rand(0...grid[0].length)]
      locations << location unless locations.include?(location)
    end

    locations
  end

  def self.populate_grid(grid, bomb_locations)
    grid.each_with_index do |row, r|
      row.each_index do |c|
        is_bomb = bomb_locations.include?([r, c])
        current_tile = Tile.new(is_bomb)
        adjacent_bomb_count = count_bombs([r, c], bomb_locations)
        current_tile.adjacent_bomb_count = adjacent_bomb_count
        grid[r][c] = current_tile
      end
    end
    grid
  end

  def self.count_bombs(pos, bomb_locations)
    bomb_count = 0
    r, c = pos

    ADJACENCY_DELTAS.each do |d_r, d_c|
      bomb_count += 1 if bomb_locations.include?([r + d_r, c + d_c])
    end

    bomb_count
  end

  private_class_method :count_bombs, :populate_grid, :generate_bomb_pos

  def initialize(grid)
    @grid = grid
  end

  def reveal(pos)
    r, c = pos
    tile = @grid[r][c]

    tile.reveal
    tile_value = tile.to_s

    if tile_value == "0"
      get_neighbors(pos).each do |n_r, n_c|
        neighbor = @grid[n_r][n_c]
        reveal([n_r, n_c]) unless neighbor.is_revealed
      end
    end

  end

  def flag(pos)

  end

  def render
    @grid.each do |row|
      puts row.map(&:to_s).join(" ")
    end
  end

  def game_over?
    @grid.each do |row|
      row.each do |tile|
        return false if !tile.is_bomb && !tile.is_revealed
      end
    end
    true
  end

  private

  def valid_pos?(pos)
    r, c = pos
    r.between?(0, @grid.length - 1) && c.between?(0, @grid[0].length - 1)
  end

  def get_neighbors(pos)
    r, c = pos
    neighbor_pos = []
    ADJACENCY_DELTAS.each do |d_r, d_c|
      current_pos = [r + d_r, c + d_c]
      neighbor_pos << current_pos if valid_pos?(current_pos)
    end
    neighbor_pos
  end

end
