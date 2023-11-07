class MoveValidator
    attr_accessor :board
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
        if from in @board.get_open_adjacent_locations(to) or loop.find_looping_path_to_piece(from, to)
            return true
        end
        false
    end
end