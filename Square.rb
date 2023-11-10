class Square
  attr_accessor :location, :loops, :piece

  def initialize(location, loops)
    @location = location
    @loops = loops
    @piece = nil
  end

  def get_locations
    @location
  end

  def get_piece
    @piece
  end

  def set_piece(piece)
    @piece = piece
  end

  def remove_piece
    @piece = nil
  end

  def is_empty
    @piece.nil?
  end

  def get_loops
    @loops
  end
end
