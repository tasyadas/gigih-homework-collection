require './db/mysql_connector'

class Category
    attr_accessor :name, :id, :items
    @@client = create_db_client

    def initialize(param)
        @id    = param.key?(:id) ? param[:id] : nil
        @name  = param[:name]
        @items = []
    end

    def save
        return false unless valid?

        @@client.query("insert into categories(name) values('#{@name}')")
    end

    def valid?
        return false if @name.nil?
        true
    end

    def self.get_all_categories
        dbRaw = @@client.query("select * from categories")
    
        categories = Array.new
    
        dbRaw.each do |data|
            category = Category.new({
                :id => data['id'], 
                :name => data['name']
            })

            categories.push(category)
        end
    
        categories
    end

    def self.get_all_category_with_items
        dbRaw = @@client.query("
            select categories.*, items.name as item_name, items.id as item_id, items.price as item_price from categories
            join item_categories on item_categories.category_id = categories.id
            join items on items.id = item_categories.item_id
        ")
    
        categories = Array.new
    
        dbRaw.each do | data |
            item = Item.new({'name' => data["item_name"], 'price' => data["item_price"], :id => data["item_id"]})

            category = categories.find{|h| h.id == data['id']}
            if category
                category.items.push(item)
            else
                category = Category.new(data)
                category.items.push(item)
                categories.push(category)
            end
        end
    
        categories
    end
end