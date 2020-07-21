# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

puts "−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−\n\n"

round = 1

puts 'Choisissez un pseudo : '
user_name = gets.chomp.to_s

puts "\n=============== INIT ====================\n\n"

game = Game.new(user_name, 4)

game.show_players

puts "\n=============== START ===================\n\n"

while game.is_still_ongoing?
  puts "\n––––––––––––– ACTION #{round} ––––––––––––––––––\n\n"

  action = game.menu

  game.menu_choice(action)

  game.enemies_attacks

  puts ''

  game.show_players

  round += 1
end

game.end
