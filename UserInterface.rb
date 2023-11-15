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

        move_done = false
        while @game.check_for_winner == nil

            while move_done == false
                player = @game.player_manager.get_current_player
                print("Current Board:\n\n")
                print(@game.board.get_board_string)
                if player == :black
                    player_print = "Black player (0)"
                else
                    player_print = "White player (X)"
                end

                print(player_print + ", Please select a piece to move (x,y):")

                # get user input
                input = gets
                if input.nil? || input.empty? || input.strip.empty?
                    display_invalid_input_error()
                    # move_done = false
                    move_done = true
                # input is valid
                elsif @validator.input_is_coordinate(input) == true
                    input = input.chomp # remove newline
                    x, y = input.split(',')
                    x = x.to_i
                    y = y.to_i
                    x = x - 1
                    y = y - 1
                    # init from coordinate
                    from = Coordinate.new(x,y)

                    print(player_print + ", Please select a location to move to (x,y):")

                    # get user input
                    input = gets
                    if input.nil? || input.empty? || input.strip.empty?
                        display_invalid_input_error()
                        move_done = false
                    # input is valid
                    elsif @validator.input_is_coordinate(input) == true
                        input = input.chomp # remove newline
                        x, y = input.split(',')
                        x = x.to_i
                        y = y.to_i
                        x = x - 1
                        y = y - 1
                        # init to coordinate
                        to = Coordinate.new(x,y)

                        # call game function

                        res = @game.make_move(from,to)

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
            move_done = false

        end

        display_winner(@game.player_manager.current_player)
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
        print("✓ Move successfully made. Piece at " + [from.get_coordinate[0] + 1, from.get_coordinate[1] + 1].join(', ') + " moved to " + [to.get_coordinate[0] + 1, to.get_coordinate[1] + 1].join(', ') + "\n")
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
