class Coordinate
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def get_coordinate
    [@x, @y]
  end
end
