require './load_surakarta.rb'

class Board

	attr_accessor :board, :validator

	def initialize()
		# TODO - dont know what loops are supposed to be
		@board = initialize_board
		@loops = initialize_loops
		@validator = MoveValidator.new(self)
	end

	def get_square(location)
		x, y = location.x, location.y
		@board[y][x]
	end

	def get_piece(location)
		the_square = get_square(location)
		the_square.get_piece
	end

	def move_piece(from, to)
		fr_square = get_square(from)
		to_square = get_square(to)
		piece_to_be_moved = fr_square.piece
		if piece_to_be_moved.nil?  || @validator.validate_move(from, to) == false
			return false
		end
		to_square.piece = piece_to_be_moved
		fr_square.piece = nil
		return true
	end

	def get_open_adjacent_locations(location)
		x, y = location.x, location.y
		adjacent_locations = []
		[-1, 0, 1].each do |cy|
			[-1, 0, 1].each do |cx|
				nx = x + cx
				ny = y + cy
				if nx.between?(0, 5) && ny.between?(0, 5)
					adj_coordinate = Coordinate.new(nx, ny)
					if get_square(adj_coordinate).get_piece == nil
						adjacent_locations.append(adj_coordinate)
					end

				end
			end
		end
		adjacent_locations

	end

	def get_board_string
		board_string = "   1 2 3 4 5 6\n |-------------\n"
		row_index = 0
		@board.each do |row|
			square_index = 0
			row.each do |square|

				if square_index == 0
					board_string += (row_index+1).to_s + "| "
				end

				piece = square.piece
				if piece.nil?
					board_string += ". "
				else
					if (piece.owner.to_s == "black")
						player_piece = "0"
					else
						player_piece = "X"
					end
					board_string += player_piece + " "
				end
				square_index += 1
			end
			board_string += "\n"
			row_index += 1
		end
		board_string += "\nOuter Loops: 3,1 <--> 1,3 / 4,1 <--> 6,3 / 6,4 <--> 4,6 / 1,4 <--> 3,6\n"
		board_string += "Inner Loops: 2,1 <--> 1,2 / 5,1 <--> 6,2 / 6,5 <--> 5,6 / 1,5 <--> 2,6\n\n"
		board_string
	end

	def initialize_board
		board = Array.new(6){Array.new(6)}
		# (0..1).each do |y|
		(0..0).each do |y|
			(0..5).each do |x|
				# TODO - don't know what loops is supposed to be
				sq = Square.new(Coordinate.new(x,y), [])
				sq.set_piece(Piece.new(Player::WHITE, sq))
				board[y][x] = sq
			end
		end
		# (2..3).each do |y|
		(1..3).each do |y|
			(0..5).each do |x|
				sq = Square.new(Coordinate.new(x,y), [])
				sq.remove_piece
				board[y][x] = sq
			end
		end
		(4..5).each do |y|
			(0..5).each do |x|
				# TODO - don't know what loops is supposed to be
				sq = Square.new(Coordinate.new(x,y), [])
				sq.set_piece(Piece.new(Player::BLACK, sq))
				board[y][x] = sq
			end
		end
		return board
	end

	def reset_pieces()
		@board.clear
		initialize_board()
	end

	def player_pieces_left(player)
		count = 0
		(0..5).each do |y|
			(0..5).each do |x|
				sq = get_square(Coordinate.new(x,y))
				if !sq.get_piece.nil?
					if sq.get_piece.get_owner == player
						count += 1
					end
				end
			end
		end
		count
	end

	def initialize_loops
		loops = []

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
        loops.push(Loop.new(loop_quadrants))

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
        loops.push(Loop.new(loop_quadrants))
		return loops
	end

	def get_loops
		@loops
	end
end
