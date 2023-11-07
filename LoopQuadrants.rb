class LoopQuadrant
  attr_accessor :loop_coordinates, :loop_entrypoints

  def initialize(loop_coordinates, loop_entrypoints)
    @loop_coordinates = loop_coordinates
    @loop_entrypoints = loop_entrypoints
  end

  def can_reach_location(start, target, board)
  end

  def can_reach_end_of_quadrant(from)
  end

  def can_reach_start_of_quadrant(from)
  end
end