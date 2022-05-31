require 'colorize'

class Tile
  attr_reader :given, :value

  def initialize(value, given = false)
    @value = value 
    if value == 0
      @given = false
    else
      @given = true
    end
  end

  def change_val(val)
    unless given
      @value = val 
    end
  end

  def color
    given ? :blue : :red
  end

  def to_s
    value == 0 ? ' ' : @value.to_s.colorize(color)
  end
end