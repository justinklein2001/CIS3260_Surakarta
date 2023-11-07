class Piece
  attr_accessor :current_square, :owner

  def initialize(owner)
    @owner = owner
    @current_square = nil #should this be in the constructor?
  end

  def get_owner
    @owner
  end

  def get_square
    @current_square
  end

  def move_to(square)
    @current_square = square
  end
end
