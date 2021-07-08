require "../inheritance/person"

class Ally < Person
    def initialize(name, hitpoint, attack_damage)
        super
    end

    def heals()
        @hitpoint += 20
    end
end