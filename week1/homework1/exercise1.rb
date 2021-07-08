class Hero
    @@chance = [true, true, true, true, true, true, true, true, false, false]
    attr_reader :name, :hitpoint, :attack_damage

    def initialize(name, hitpoint, attack_damage)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
    end
    
    def attack(other_knight)
        puts "#{@name} attack #{other_knight.name} with #{@attack_damage} points"
        other_knight.attacked(@attack_damage)
    end
    
    def attacked(damage)
        if @name == "Jin Sakai" and @@chance.shuffle.first
            damage = 0
            puts "#{@name} deflects the attack."
        end
        @hitpoint -= damage
        puts self
    end
 
    def to_s
        return "#{@name} has #{@hitpoint} hitpoints and #{@attack_damage} attack"
    end
 
    def is_alive?
        return @hitpoint > 0
    end
end

jin_sakai = Hero.new("Jin Sakai", 100, 50)
khotun_khan = Hero.new("Khotun Khan", 500, 50)
 
is_jin_sakai_turn = true
 
while jin_sakai.is_alive? and khotun_khan.is_alive?
    if is_jin_sakai_turn
        jin_sakai.attack(khotun_khan)
    else
        khotun_khan.attack(jin_sakai)
    end
    is_jin_sakai_turn = !is_jin_sakai_turn
    puts
end
 
if jin_sakai.is_alive?
    puts "Khotun Khan dies"
else
    puts "Jin Sakai dies"
end