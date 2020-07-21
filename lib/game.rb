# frozen_string_literal: true

class Game
  attr_accessor :human_player, :enemies

  def initialize(user_name, nb_enemy)
    @human_player = HumanPlayer.new(user_name)
    @enemies = []

    nb_enemy.times do |i|
      @enemies << Player.new("ennemi_#{i + 1}")
    end
  end

  def kill_enemy(enemy)
    puts enemy.name
    @enemies.delete(enemy.name.to_s)
  end

  def is_still_ongoing?
    if @human_player.life_points.positive? && (@enemies[0].life_points.positive? || @enemies[1].life_points.positive? || @enemies[2].life_points.positive? || @enemies[3].life_points.positive?)
      return true

    else
      return false
    end
  end

  def show_players
    puts @human_player.show_state
    puts "   → Il y a #{@enemies.length} ennemis"
  end

  def menu
    index = 0

    begin
      puts "=> Quelle action veux-tu effectuer ?"
      puts '    a - Chercher une meilleure arme'
      puts "    s - Chercher à se soigner\n\n"
      puts '→ Attaquer un joueur en vue :'

      @enemies.each { |enemy| 
        puts "    #{index + 1} - " + enemy.show_state + "\n" if enemy.life_points.positive?

        index +=1
      }

      print "\nChoix : "

      return gets.chomp.to_s
    end
  end

  def menu_choice(action)
    case action
    when 'a'
      @human_player.search_weapon

    when 's'
      @human_player.search_health_pack

    when '1'
      @human_player.attacks(@enemies[0])
      kill_enemy(@enemies[0]) if @enemies[0].life_points.negative?

    when '2'
      @human_player.attacks(@enemies[1])
      kill_enemy(@enemies[1]) if @enemies[1].life_points.negative?

    when '3'
      @human_player.attacks(@enemies[2])
      kill_enemy(@enemies[2]) if @enemies[2].life_points.negative?

    when '4'
      @human_player.attacks(@enemies[3])
      kill_enemy(@enemies[3]) if @enemies[3].life_points.negative?

    end
  end

  def enemies_attacks
    puts "\nLes autres joueurs t'attaquent !\n\n"

    @enemies.each { |enemy| enemy.attacks(@human_player) }
  end

  def end
    if @human_player.life_points.positive?
      puts 'Bravo ! Tu as gagné !'
    else
      puts 'Game Over !'
    end
  end
end
