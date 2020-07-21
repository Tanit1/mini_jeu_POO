# frozen_string_literal: true

class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name        = name
    @life_points = 10
  end

  def show_state
    if @life_points > 0
      return "#{@name} a #{@life_points} points de vie."
    else
      return "#{@name} a 0 points de vie."
    end
  end

  def get_damage(damage)
    @life_points = @life_points - damage

    if @life_points <= 0
      puts "\n–––––––––––––– KILL ––––––––––––––––––––"
      puts "\n      Le joueur #{@name} est mort !"
      puts "\n––––––––––––––––––––––––––––––––––––––––\n"
    end
  end

  def attacks(player)
    damage = compute_damage
    puts "=> #{@name} attaque #{player.name}"
    puts "   → Il lui inflige #{damage} points de dommages."

    player.get_damage(damage)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    @weapon_level = 1
    @name         = name
    @life_points  = 100
  end

  def show_state
    if @life_points > 0
      puts "=> #{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
    else
      puts "#{@name} a 0 points de vie."
    end
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)

    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"

    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level

      puts 'Cette arme est meilleur, tu la prend !'
    else
      puts "Cette arme n'est pas mieux que la tienne."
    end
  end

  def search_health_pack
    health_pack = rand(1..6)

    case health_pack
    when 1
      puts "Tu n'as rien trouvé…"
    when (2...5)
      @life_points += 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      @life_points += 80
      puts 'Waow, tu as trouvé un pack de +80 points de vie !'
    end

    check_max_life_point
  end

  def check_max_life_point
    if @life_points > 100
      life_points = 100
    end
  end
end
