require './load_surakarta.rb'

class Board

	attr_accessor :board, :validator
	
	def initialize()
		# TODO - dont know what loops are supposed to be
		@board = (0..5).map { |i| (0..5).map { |j| Square.new(Coordinate.new(i,j), []) } }
		@validator = MoveValidator.new(self)
		initialize_board()
	end

	def get_square(location)
		x, y = location.x, location.y
		puts @board[x][y].get_piece
		@board[x][y]
	end

	def get_piece(location)
		the_square = get_square(location)
		the_square.get_piece
	end

	def move_piece(from, to)
		fr_square = get_square(from)
		to_square = get_square(to)
		piece_to_be_moved = fr_square.piece
		if piece_to_be_moved.nil? || @validator.validate_move(from, to) == false
			return false
		end
		
		to_square.piece = piece_to_be_moved
		fr_square.piece = nil
		return true
	end

	def get_open_adjacent_locations(location) 
		x, y = location.x, location.y
		adjacent_locations = []

		[-1, 0, 1].each do |cx|
			[-1, 0, 1].each do |cy|
				nx, ny = x + cx, y + cy			
				if nx.between?(0, 5) && ny.between?(0, 5)
					adj_coordinate = Coordinate.new(nx, ny)
					if get_square(adj_coordinate).is_empty
						puts "here", nx, ny
						puts adjacent_locations
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

	def initialize_board()
		(0..1).each do |x|
			(0..5).each do |y|
				# TODO - don't know what loops is supposed to be
				sq = Square.new(Coordinate.new(x,y), [])
				sq.set_piece(Piece.new(Player::WHITE, sq))
				@board[x][y] = sq
			end
		end
		(2..3).each do |x|
			(0..5).each do |y|
				sq = Square.new(Coordinate.new(x,y), [])
				sq.set_piece(nil)
				@board[x][y] = sq
			end
		end
		(4..5).each do |x|
			(0..5).each do |y|
				# TODO - don't know what loops is supposed to be
				sq = Square.new(Coordinate.new(x,y), [])
				sq.set_piece(Piece.new(Player::BLACK, sq))
				@board[x][y] = sq
			end
		end
	end

	def reset_pieces()
		@board.clear
		initialize_board()
	end

	def player_pieces_left(player)
		count = 0
		(0..5).each do |x|
			(0..5).each do |y|
				sq = get_square(Location.new(x, y))
				if sq.piece.get_owner() == player
					count += 1
				end
			end
		end
		count
	end

end