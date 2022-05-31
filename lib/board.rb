require_relative './tile'

class Board
  SET = (1..9).to_a
  def self.init_grid
    Array.new(9) { Array.new(9) { Tile.new(0) }}
  end

  def self.from_file(filename)
    lines = File.readlines("../puzzles/#{filename}").map(&:chomp)
    tiles = lines.map do |row|
      nums = row.chars.map(&:to_i)
      nums.map { |num| Tile.new(num)}
    end

    self.new(tiles) 
  end

  def initialize(grid = Board.init_grid)
    @grid = grid 
  end

  def [](pos)
    row, col = pos[0], pos[1]
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos[0], pos[1]
    grid[row][col].change_val(value)
  end

  def render  
    puts "  #{(0..8).to_a.join(' ')}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
  end

  def solved?
    rows && cols && blocks
  end

  def size
    @grid.size
  end

  private

  attr_reader :grid

  def rows
    grid.all? do |row|
      nums = row.map { |tile| tile.value.to_i }
      nums.sort == SET
    end
  end

  def cols
    grid.each_index do |i|    
      (grid.select { |row| row[i]}).all? do |col| 
        nums = col.map { |tile| tile.value.to_i }

        nums.sort == SET
      end
    end
  end

  def blocks
    (0..8).step(3) do |i|
      block = (grid[i..(i + 2)]).map { |row| row[i..(i + 2)] }

      nums_block = []
      block.each do |row|
          nums_block << row.map(&:value)
      end

      return false unless nums_block.flatten.sort == SET
    end

    true
  end
end