require '../inheritance/hero'
require '../polymorph/mongol_archer'
require '../polymorph/mongol_spearman'
require '../polymorph/mongol_swordsman'
require_relative 'ally'

jin = Hero.new("Jin Sakai", 100, 50)
ally_yuna = Ally.new("Yuna", 90, 45)
ally_sensei_ishikawa = Ally.new("Sensei Ishikawa", 80, 60)

mongol_archer = MongolArcher.new("Mongol Archer", 80, 40)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50)

heroes = [jin, ally_yuna, ally_sensei_ishikawa]
villains = [mongol_archer, mongol_spearman, mongol_swordsman]

i = 1
until (jin.die? || villains.empty?) do
    puts "========== Turn #{i} =========="
    puts "\n"

    puts jin
    villains.each do |villain|
        puts villain
    end
    puts "\n"

    puts "As Jin Sakai, what do you want to do this turn?"
    puts "\n"
    puts "1) Attack an enemy"
    puts "2) Heal an ally"
    action = gets.chomp.to_i

    if action == 1
        puts "Which enemy you want to attack?"
        j = 1
        villains.each do |villain|
            puts "#{j}) #{villain}"
            j += 1
        end
        enemy = villains[gets.chomp.to_i - 1]
        jin.attack(enemy)
        villains.delete(enemy) if enemy.die? || enemy.flee?
    elsif action == 2
        puts "Which ally you want to heal?"
        j = 1
        until (j == (heroes.size)) do
            puts "#{j}) #{heroes[j]}"
            j += 1
        end
        hero = heroes[gets.chomp.to_i]
        jin.heal_ally(hero)
    end
    puts "\n"

    villains.each do |villain|
        hero = heroes[rand(heroes.size - 1)]
        villain.attack(hero)
        heroes.delete(hero) if hero.die?
    end
    puts "\n"

    i += 1
end