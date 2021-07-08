require '../inheritance/villain'

class MongolSwordsman < Villain
    def attack(other_knight)
        puts "#{@name} slashes #{other_knight.name} with #{@attack_damage} damage"
        other_knight.take_damage(@attack_damage)
    end
end