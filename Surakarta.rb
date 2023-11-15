require './load_surakarta.rb'

players = [Player::WHITE, Player::BLACK]
player_manager = PlayerManager.new(players)
game = Game.new(player_manager)
game.start()