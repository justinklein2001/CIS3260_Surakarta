class LoopQuadrant
  attr_accessor :loop_coordinates, :loop_entrypoints

  def initialize(loop_coordinates, loop_entrypoints)
    @loop_coordinates = loop_coordinates
    @loop_entrypoints = loop_entrypoints
  end

  def can_reach_location(start, to_end, board)
    open_locations = board.get_open_adjacent_locations(start)
    open_entry_points = []

    # find an entry point that is open
    for entry in @loop_entrypoints
      for location in open_locations
        if entry == location
          open_entry_points.push(location)
        end
      end
    end

    # loop through @loop_coordinates and try to find if end is contained
    for entry in open_entry_points
      for coordinate in @loop_coordinates
        if entry == coordinate
          # How do we know if this entry is before or after going through the loop???
          return true
        end
      end
    end
    return false
  end

  def can_reach_end_of_quadrant(from)
    # This doesn't have access to the board so how do we know if there is a collision?
  end

  def can_reach_start_of_quadrant(from)
    # This doesn't have access to the board so how do we know if there is a collision?
  end
end