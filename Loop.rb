class Loop
  attr_accessor :quadrants
  
  def initialize
    @quadrants = [LoopQuadrant.new([], []), LoopQuadrant.new([], []), LoopQuadrant.new([], []), LoopQuadrant.new([], [])]
  end
  
  def find_looping_path_to_piece(start, target)
  end
end    