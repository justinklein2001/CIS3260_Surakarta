require './load_surakarta.rb'

class MoveValidator
    attr_accessor :board
    def initialize(board)
        @board = board
    end


    def validate_move(from, to)
        fx, fy = from.x, from.y
        tx, ty = to.x, to.y

        open_spots = @board.get_open_adjacent_locations(from)

        open_spots.each do |spot|
            if (spot.x == tx && spot.y == ty)
                return true
            end
        end
        puts @board.get_loops[0].find_looping_path_to_piece(from, to, @board, @board.get_piece(from).get_owner)
        puts @board.get_loops[1].find_looping_path_to_piece(from, to, @board, @board.get_piece(from).get_owner)
        if ((@board.get_loops[0].find_looping_path_to_piece(from, to, @board, @board.get_piece(from).get_owner) == true) or (@board.get_loops[1].find_looping_path_to_piece(from, to, @board, @board.get_piece(from).get_owner) == true))
            return true
        end
       
        false
    end
end
