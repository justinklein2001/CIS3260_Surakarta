class Loop
  attr_accessor :quadrants
  
  def initialize(quadrants)
    @quadrants = quadrants
  end
  
  # Returns a boolean indicating whether a looping path to a piece exists
  # from the start to the end.
  def find_looping_path_to_piece(from, to, board, player)

    # create local version of quadrants
    quadrants = @quadrants

    # find the starting quadrant
    starting_quadrant = 4
    for i in 0..3
      if quadrants[i].is_piece_in_quadrant(from)
        starting_quadrant = i
        break
      end
    end
    # return false if from is not in loop
    if starting_quadrant == 4
      return false
    end

    # update the quadrant array to start with the starting quadrant
    quadrants.rotate!(starting_quadrant)

    # start looking from the from piece
    start = from

    has_gone_through_loop = false
    is_first_loop = false

    # look through quadrants in order
    quadrants.each do |quadrant|

      # get last square hit in quadrant
      end_square = quadrant.can_reach_end_of_quadrant(from, board, is_first_loop)
      is_first_loop = true

      # check if piece goes through a loop
      if quadrant.is_loop_between(start, end_square.get_location)
        has_gone_through_loop = true
      end

      # if end of quadrant move on to next one
      if end_square.is_empty
        # set start to be begining of next quadrant
        start = end_square.get_location
        next
      end

      # if ended on own piece then stop looking 
      if end_square.get_piece.get_owner == player
        break

      # if ended on opponent piece
      elsif end_square.get_piece.get_owner != player

        # if end location is goal location return true and piece has gone through a loop
        if end_square.get_location == to && has_gone_through_loop
          return true
        else
          # if not then stop looking
          break
        end
      end
    end

    # reset variables
    has_gone_through_loop = false
    is_first_loop = false
    start = from

    # Reverse all elements except for the first index
    quadrants[1..3] = quadrants[1..3].reverse

    # look through quadrants in reverse order
    quadrants.each do |quadrant|

      # get last square hit in quadrant
      end_square = quadrant.can_reach_start_of_quadrant(from, board, is_first_loop)
      is_first_loop = true

      # check if piece goes through a loop
      if quadrant.is_loop_between(start, end_square.get_location)
        has_gone_through_loop = true
      end

      # if end of quadrant move on to next one
      if end_square.is_empty
        # set start to be begining of next quadrant
        start = end_square.get_location
        next
      end

      # if ended on own piece then stop looking 
      if end_square.get_piece.get_owner == player
        break

      # if ended on opponent piece
      elsif end_square.get_piece.get_owner != player

        # if end location is goal location return true and piece has gone through a loop
        if end_square.get_location.x == to.x && end_square.get_location.y == to.y && has_gone_through_loop
          return true
        else
          # if not then stop looking
          break
        end
      end
    end

    # if not path not found return false
    return false

  end
end    