require '../inheritance/villain'

class MongolArcher < Villain
    def attack(other_knight)
        puts "#{@name} shoots an arrow at #{other_knight.name} with #{@attack_damage} damage"
        other_knight.take_damage(@attack_damage)
    end
end