# Author: Justin Klein
# Date: 2023-11-02
# Class Name: UserInteface.rb
class UserInterface
    
    # design calls for game to be here, that's wrong
    def initialize(validator)
        @validator = validator
    end

    # this should not be here
    def make_move(from, to)
    end

    # Displays the winner of the game to the user
    def display_winner()
    end

    # Displays a message to the user indicating a successful move.
    def display_successful_move()
    end

    # Displays a message to the user indicating an invalid input error.
    def display_invalid_input_error()
    end

    # Displays a message to the user indicating an invalid move error.
    def display_invalid_move_error()
    end
end


