require_relative 'person'

class Hero < Person
    def initialize(name, hitpoint, attack_damage)
        super(name, hitpoint, attack_damage)
        @deflects_percentage = 0.8
    end

    def take_damage(damage)
        if rand < @deflects_percentage
            puts "#{@name} deflects the attack."
        else
            @hitpoint -= damage
        end
    end

    def heal_ally(ally)
        ally.heals
        puts "#{@name} heals #{ally.name}, restoring 20 hitpoints"
    end
end