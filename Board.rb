require './load_surakarta.rb'

class Board

	attr_accessor :board, :validator
	
	def initialize(player_manager)
		@board = (0..6).map { |i| (0..6).map { |j| Square.new(Coordinate.new(i,j)) } }
		@validator = MoveValidator.new()
		initialize_board(player_manager)
		@player_manager = player_manager
	end

	def get_square(location)
		x, y = location.x, location.y
		@board[x][y]
	end

	def get_piece(location)
		sqaure = get_square(location)
		square.piece
	end

	def move_piece(from, to)
		fr_square = get_square(from)
		to_square = get_square(to)
		piece_to_be_moved = from_square.piece

		if piece_to_be_moved.nil || !@validator.validate_move?(from, to, @board)
			return false
		end
		
		to_square.piece = piece_to_be_moved
		fr_square.piece = nil
		true
	end

	def get_open_adjacent_locations(location) 
		x, y = location.x, location.y
		adjacent_locations = []

		[-1,1].each do |cx|
			[-1, 1].each do |cy|
				nx, ny = x + cx, y + cy
				if nx.between?(0, 7) && ny.between?(0, 7)
					adj_coordinate = Coordinate.new(nx, ny)
					if get_piece(adj_coordinate).nil?
						adjacent_locations.append(adj_coordinate)
					end
				end
			end
		end

		adjacent_locations

	end	

	def get_board_string
		board_string = ""
		@board.each do |row|
			row.each do |square|
				piece = square.piece
				if piece.nil?
					board_string += ". "
				else
					board_string += piece.to_s + " "
				end
			end
			board_string += "\n"
		end
		board_string
	end

	def initialize_board()
		(0..1).each do |x|
			(0..5).each do |y|
				sq = Square.new(Coordinate.new(x,y))
				sq.set_piece(Piece.new(@player_manager.players[0]))
				@board[x][y] = sq
			end
		end
		(4..5).each do |x|
			(0..5).each do |y|
				sq = Square.new(x, y)
				sq.set_piece(Piece.new(Player.new(@player_manager.players[1])))
				@board[x][y] = sq
			end
		end
	end

	def reset_pieces()
		@board.clear
		initialize_board(@player_manager)
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