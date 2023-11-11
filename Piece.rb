
class Piece
  attr_accessor :current_square, :owner

  def initialize(owner, current_square)
    @owner = owner
    @current_square = current_square
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
