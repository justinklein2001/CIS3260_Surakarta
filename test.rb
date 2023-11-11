require './load_surakarta.rb'

# validator = UserInterfaceValidator.new()
# user_inteface = UserInterface.new(validator)
players = [Player::WHITE, Player::BLACK]
player_manager = PlayerManager.new(players)
game = Game.new(player_manager)
game.start()