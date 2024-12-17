# Harir AL-Rubaye
# Date: 2023-11-02

class PlayerManager
  attr_accessor :current_player
    def initialize(players)
      if players.length != 2 
        raise ArgumentError, "PlayerManager requires an array of two Player enumeration values."
      end
      @players = players
      @current_player = @players[0]
    end
    
    def get_current_player
      @current_player
    end

    def swap_player
      @current_player = (@current_player == Player::WHITE) ? Player::BLACK : Player::WHITE
    end
  end
  