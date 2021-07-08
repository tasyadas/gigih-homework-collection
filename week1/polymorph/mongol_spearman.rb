require '../inheritance/villain'

class MongolSpearman < Villain
    def attack(other_knight)
        puts "#{@name} thrusts #{other_knight.name} with #{@attack_damage} damage"
        other_knight.take_damage(@attack_damage)
    end
end