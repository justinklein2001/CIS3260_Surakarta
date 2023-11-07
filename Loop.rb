class Loop
  attr_accessor :quadrants
  
  def initialize
    @quadrants = [LoopQuadrant.new([], []), LoopQuadrant.new([], []), LoopQuadrant.new([], []), LoopQuadrant.new([], [])]
  end
  
  def find_looping_path_to_piece(start, end)
    # This doesn't have access to the board so how do we know if there is a collision?
  end
end    