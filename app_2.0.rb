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
enemies = []
action = ""

puts 'Choisissez un pseudo : '
user_name = gets.chomp.to_s

puts "\n============== INIT ====================\n\n"

user = HumanPlayer.new(user_name)
enemy_1 = Player.new('Poséïdon')
enemy_2 = Player.new('Neth')

enemies.push(enemy_1, enemy_2)

user.show_state
enemies.each { |enemy| enemy.show_state}

puts "\n=============== START ==================="

while user.life_points.positive? && (enemy_1.life_points.positive? || enemy_2.life_points.positive?)
  begin
    puts "\n=> Quelle action veux-tu effectuer ?"
    puts '    a - Chercher une meilleure arme'
    puts '    s - Chercher à se soigner'
    puts 'Attaquer un joueur en vue :'
    puts '    0 - ' + enemy_1.show_state + "\n" if enemy_1.life_points.positive?
    puts '    1 - ' + enemy_2.show_state + "\n" if enemy_2.life_points.positive?
    print 'Choix : '

    action = gets.chomp.to_s
  end

  puts "\n––––––––––––– ACTION #{round} ––––––––––––––––––"

  case action
  when 'a'
    user.search_weapon
  when 's'
    user.search_health_pack
  when '0'
    user.attacks(enemy_1)
  when '1'
    user.attacks(enemy_2)
  end

  if enemy_1.life_points.positive? || enemy_2.life_points.positive? 
    puts "\nLes autres joueurs t'attaquent !\n\n"
  end

  enemies.each { |enemy| enemy.attacks(user) if enemy.life_points.positive? }

  puts ''
  user.show_state

  round += 1
end

puts '=============== END ===================='

if user.life_points.positive?
  puts 'Bravo ! Tu as gagné !'
else
  puts 'Game Over !'
end
