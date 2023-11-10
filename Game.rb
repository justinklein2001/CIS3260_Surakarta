# Harir AL-Rubaye
# Date: 2023-11-06
require './load_surakarta.rb'

class Game
  attr_accessor :player_manager, :board

  def initialize(player_manager)
    @player_manager = player_manager
    @board = Board.new()
    validator = UserInterfaceValidator.new()
    @ui = UserInterface.new(validator, self)
  end

  def start
    @ui.make_move()
  end

  def make_move(from, to)
    # puts @board.move_piece(from, to)
    # puts from.get_coordinate.join(', '), to.get_coordinate.join(', ')
    if @board.move_piece(from, to)

      @ui.display_successful_move(from, to)
      winner = check_for_winner
      if winner
        @ui.display_winner(winner)
      else
        @player_manager.swap_player
        true
      end
    else

      false
    end
  end

  def check_for_winner
    if @board.player_pieces_left(@player_manager.current_player) == 0
      @player_manager.players.find { |player| player != @player_manager.current_player }
    else
      nil
    end
  end
end
