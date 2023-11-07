class MoveValidator
    attr_accessor :board
    def initialize(board)
        @board = board
    end

    def validate_move(from, to)
        fx, fy = from.x, from.y
        tx, ty = to.x, to.y
        if @board.get_piece(from).nil?
            return false
        end 
        if from in @board.get_open_adjacent_locations(to) or
    end
end