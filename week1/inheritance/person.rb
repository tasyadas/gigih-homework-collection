class Person
    attr_reader :name, :hitpoint, :attack_damage

    def initialize(name, hitpoint, attack_damage)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
    end
    
    def attack(other_knight)
        puts "#{@name} attacks #{other_knight.name} with #{@attack_damage} damage"
        other_knight.take_damage(@attack_damage)
    end
    
    def take_damage(damage)
        @hitpoint -= damage
    end

    def die?
        return @hitpoint <= 0
    end
end