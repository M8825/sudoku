require_relative './board'

class Game
  def initialize(filename)
    @board = Board.from_file(filename)
  end

  def play
    until @board.solved?
      system('clear')
      @board.render

      pos, val = prompt
      @board[pos] = val
    end

    @board.render
    puts 'Solved!'
  end

  def prompt
    pos = nil
    until pos
      puts 'Please enter the position and value (e.g., \'2,3 1\')'
      valid_pos_val = user_input
      pos = valid_pos_val if valid_pos_val
    end
    pos
  end

  private

  def user_input 
    arr = gets.chomp.split(' ')

    return false unless arr.size == 2 && valid_pos?(arr[0]) && valid_val?(arr[1])

    pos = arr[0].split(',').map(&:to_i)
    val = arr[1].to_i

    [pos, val]
  end

  def valid_pos?(str)
    chars = str.split(',').map { |num| num.to_i if is_number?(num)}

    chars.all? { |num| num.is_a? Integer } && chars.size == 2 && (chars[0] < size && chars[1] < size)
  end

  def valid_val?(str)
    is_number?(str) && str.to_i <= size
  end

  def size
    @board.size
  end

  def is_number?(str)
    true if Float(str) rescue false
  end
end