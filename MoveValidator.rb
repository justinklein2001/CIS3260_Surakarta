require './load_surakarta.rb'

class MoveValidator
    attr_accessor :board
    def initialize(board)
        @board = board
    end


    def validate_move(from, to)
        fx, fy = from.x, from.y
        tx, ty = to.x, to.y
        loop_quadrants = []
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(1,1),
            Coordinate.new(1,0),
            Coordinate.new(0,1),
            Coordinate.new(1,1),
            Coordinate.new(2,1),
            Coordinate.new(3,1),
            Coordinate.new(4,1)
        ],[
            Coordinate.new(1,0),
            Coordinate.new(0,1)
        ]))
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(4,1),
            Coordinate.new(5,1),
            Coordinate.new(4,0),
            Coordinate.new(4,1),
            Coordinate.new(4,2),
            Coordinate.new(4,3),
            Coordinate.new(4,4)
        ],[
            Coordinate.new(5,1),
            Coordinate.new(4,0)
        ]))
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(4,4),
            Coordinate.new(4,5),
            Coordinate.new(5,4),
            Coordinate.new(4,4),
            Coordinate.new(3,4),
            Coordinate.new(2,4),
            Coordinate.new(1,4)
        ],[
            Coordinate.new(4,5),
            Coordinate.new(5,4)
        ]))
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(1,4),
            Coordinate.new(0,4),
            Coordinate.new(1,5),
            Coordinate.new(1,4),
            Coordinate.new(1,3),
            Coordinate.new(1,2),
            Coordinate.new(1,1)
        ],[
            Coordinate.new(0,4),
            Coordinate.new(1,5)
        ]))
        inner_loops = Loop.new(loop_quadrants)

        loop_quadrants = []
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(2,2),
            Coordinate.new(2,1),
            Coordinate.new(2,0),
            Coordinate.new(0,2),
            Coordinate.new(1,2),
            Coordinate.new(2,2),
            Coordinate.new(3,2)
        ],[
            Coordinate.new(2,0),
            Coordinate.new(0,2)
        ]))
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(3,2),
            Coordinate.new(4,2),
            Coordinate.new(5,2),
            Coordinate.new(3,0),
            Coordinate.new(3,1),
            Coordinate.new(3,2),
            Coordinate.new(3,3)
        ],[
            Coordinate.new(5,2),
            Coordinate.new(3,0)
        ]))
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(3,3),
            Coordinate.new(3,4),
            Coordinate.new(3,5),
            Coordinate.new(5,3),
            Coordinate.new(4,3),
            Coordinate.new(3,3),
            Coordinate.new(2,3)
        ],[
            Coordinate.new(3,5),
            Coordinate.new(5,3)
        ]))
        loop_quadrants.push(LoopQuadrant.new([
            Coordinate.new(2,3),
            Coordinate.new(1,3),
            Coordinate.new(0,3),
            Coordinate.new(2,5),
            Coordinate.new(2,4),
            Coordinate.new(2,3),
            Coordinate.new(2,2)
        ],[
            Coordinate.new(0,3),
            Coordinate.new(2,5)
        ]))
        outer_loops = Loop.new(loop_quadrants)

        if @board.get_piece(from).nil?
            return true
        end 
        open_spots = @board.get_open_adjacent_locations(from)
        # open_spots.each do |spot|
        #     puts("here", spot.get_coordinate.join(', '))
        # end
        if ((open_spots.include? from) or (inner_loops.find_looping_path_to_piece(from, to, @board, @board.get_piece(from).get_owner) == true) or (outer_loops.find_looping_path_to_piece(from, to, @board, @board.get_piece(from).get_owner) == true))
            return true
        end
        false
    end
end