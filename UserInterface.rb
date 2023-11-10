require './Coordinate.rb'

# Author: Justin Klein
# Date: 2023-11-05
# Class Name: UserInteface.rb
class UserInterface
    
    # design calls for game to be here, that's wrong
    def initialize(validator, game)
        @validator = validator
        @game = game
        print("\u{1F44B} Welcome to Surakarta\n\n")
    end

    # this should not be here
    def make_move()
        
        print("Current Board:\n\n")
        print(@game.board.get_board_string)

        player = @game.player_manager.get_current_player
        move_done = false

        while move_done == false
        
            if player == "BLACK"
                player_print = "Black player (0)"
            else
                player_print = "White player (X)"
            end

            print(player_print + ", Please select a piece to move (x,y):")

            # get user input
            input = gets
            input = input.chomp # remove newline
            
            # input is valid
            if @validator.input_is_coordinate(input) == true
                
                x, y = input.split(',')
                x = x.to_i
                y = y.to_i

                # init from coordinate 
                from = Coordinate.new(x,y)

                print(player_print + ", Please select a location to move to (x,y):")
                
                # get user input
                input = gets
                input = input.chomp # remove newline
                
                if @validator.input_is_coordinate(input) == true
                    x, y = input.split(',')
                    x = x.to_i
                    y = y.to_i
                    
                    # init to coordinate 
                    to = Coordinate.new(x,y)

                    # call game function
                    res = @game.make_move(to, from)
                    
                    if res == true

                        display_successful_move(from, to)
                        # move is done, break out of loop
                        move_done = true

                    else
                        display_invalid_move_error()
                    end
                else
                    display_invalid_input_error()
                end
            else
                display_invalid_input_error()
            end
        end
    end

    # Displays the winner of the game to the user
    def display_winner(winner)
        if winner == "BLACK"
            print("\u{1F3C6} Black player (0) has won! White player (X) has no pieces remaining!\n")
        else
            print("\u{1F3C6} White player (X) has won! Black player (0) has no pieces remaining!\n")
        end
    end

    # Displays a message to the user indicating a successful move.
    def display_successful_move(from, to)
        print("✓ Move successfully made. Piece at " + from + "moved to " + to + "\n")
    end

    # Displays a message to the user indicating an invalid input error.
    def display_invalid_input_error()
        print("\u274C Invalid input entered! Please enter a valid move\n")
    end

    # Displays a message to the user indicating an invalid move error.
    def display_invalid_move_error()
        print("\u274C Invalid move entered! Please enter a valid move.\n")
    end
end


