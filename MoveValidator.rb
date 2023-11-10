require './load_surakarta.rb'

class MoveValidator

    def initialize(board)
        @board = board
    end


    def validate_move(from, to)
        fx, fy = from.x, from.y
        tx, ty = to.x, to.y
        loop = Loop.new

        if @board.get_piece(from).nil?
            return true
        end 
        
        open_spots = @board.get_open_adjacent_locations(to)
        if ((from in open_spots) or (loop.find_looping_path_to_piece(from, to) == true))
            return true
        end
        false
    end
end