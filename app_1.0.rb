# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

# Debug
# binding.pry

round = 1

player_1 = Player.new('Poséïdon')
player_2 = Player.new('Neth')

puts '============== INIT ===================='

puts player_1.show_state
puts player_2.show_state

puts "\n============== FIGHT ==================="

while player_1.life_points.positive? && player_2.life_points.positive?
  puts "\n––––––––––––– ROUND #{round} ––––––––––––––––––"

  player_1.attacks(player_2)

  if player_2.life_points > 0
    player_2.attacks(player_1)

    puts ""
    puts player_1.show_state
    puts player_2.show_state
  end

  round += 1
end

puts '=============== END ===================='
