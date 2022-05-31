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
      @given = true unless val == 0
    end
  end

  def to_s
    given ? @value.to_s : ' ' # TODO: Needs to be colorized
  end
end