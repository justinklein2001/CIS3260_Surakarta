class LoopQuadrant
  attr_accessor :loop_coordinates, :loop_entrypoints

  def initialize(loop_coordinates, loop_entrypoints)
    @loop_coordinates = loop_coordinates
    @loop_entrypoints = loop_entrypoints
  end

  # Returns a boolean indicating whether the given coordinate is
  # included in the quadrant's coordinates
  def is_piece_in_quadrant(coordinate)
    @loop_coordinates.each do |coordinate2|
      if coordinate.x == coordinate2.x && coordinate.y == coordinate2.y
        return true
      end
    end
    return false
  end

  # Returns a boolean indicating whether 2 points in the
  # loopQuadrant have the loop between them
  def is_loop_between(from, to)
    is_passed_from = false
    is_passed_to = false
    entrypoints_passed = 0

    # check to see if from or to are in the first spot in the loop
    if @loop_coordinates.first.x == from.x &&  @loop_coordinates.first.y == from.y
      is_passed_from = true
    elsif @loop_coordinates.first.x == to.x && @loop_coordinates.first.y == to.y
      is_passed_to = true
    end

    # loop through every square in the quadrant in order
    @loop_coordinates.each do |coordinate|

      # if only 1 of the locations has been passed
      if is_passed_from ^ is_passed_to
        # check if coordinate is an entrypoint
        @loop_entrypoints.each do |entrypoints|
          if coordinate.x == entrypoints.x && coordinate.y == entrypoints.y
            entrypoints_passed += 1
          end
        end
      end

      # check to see if from or two are passed
      if @loop_coordinates.first.x == from.x &&  @loop_coordinates.first.y == from.y
        is_passed_from = true
      elsif @loop_coordinates.first.x == to.x && @loop_coordinates.first.y == to.y
        is_passed_to = true
      end

      # if both entrypoints passed while in between from and to
      if entrypoints_passed >= 2
        return true
      end
    end

    # if loop was not passed inbetween points then return false
    return false
  end

  # Returns the square indicating the coordinate of the first collision with
  # a piece, or the end of the quadrant moving forwards through the quadrant.
  # Used to see if the full quadrant can be
  # navigated through without a collision.
  def can_reach_end_of_quadrant(from, board, is_piece_moving)

    # loop through every square in the quadrant in order
    @loop_coordinates.each do |coordinate|


      # only look for a collision once we've pases the "from" piece
      if is_piece_moving

        # check if there is a collision with a piece
        if !board.get_square(coordinate).is_empty && !(coordinate.x == from.x && coordinate.y == from.y)
          return board.get_square(coordinate)
        end

      else

        # check to see if the loop has reached the "from piece"
        if coordinate.x == from.x && coordinate.y == from.y
          is_piece_moving = true
        end

      end
    end

    # if no collision found then end of quadrant reached
    if @loop_coordinates.last.x == from.x && @loop_coordinates.last.y == from.y
      return Square.new(Coordinate.new(from.x, from.y))
    end
    return board.get_square(@loop_coordinates.last)
  end

  # Returns the square indicating the coordinate of the first collision with
  # a piece, or the start of the quadrant moving backwards through the quadrant.
  # Used to see if the full quadrant can be
  # navigated through without a collision.
  def can_reach_start_of_quadrant(from, board, is_piece_moving)

    # loop through every square in the quadrant in reverse order
    @loop_coordinates.reverse_each do |coordinate|

      # only look for a collision once we've pases the "from" piece
      if is_piece_moving

        # check if there is a collision with a piece
        if !board.get_square(coordinate).is_empty && !(coordinate.x == from.x && coordinate.y == from.y)
          return board.get_square(coordinate)
        end

      else

        # check to see if the loop has reached the "from piece"
        if coordinate.x == from.x && coordinate.y == from.y
          is_piece_moving = true
        end

      end
    end

    # if no collision found then start of quadrant reached
    if @loop_coordinates.first.x == from.x && @loop_coordinates.first.y == from.y
      return Square.new(Coordinate.new(from.x, from.y))
    end
    return board.get_square(@loop_coordinates.first)
  end
end
