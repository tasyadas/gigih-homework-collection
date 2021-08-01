require './db/mysql_connector'
require './models/category'

class Item
    attr_accessor :id, :name, :price, :categories
    @@client = create_db_client

    def initialize(param)
        @id         = param.key?(:id) ? param[:id] : nil
        @name       = param[:name]
        @price      = param[:price]
        @categories = []
    end
    
    def save(categories = [])
        return false unless valid?

        # add new items
        @@client.query("insert into items(name, price) values('#{name}', '#{price}')")

        # create relationship to category
        if categories.length() >= 1
            categories.each do |category| 
                @@client.query("
                    INSERT INTO item_categories(item_id, category_id)
                    VALUES(
                        (select id AS item_id from items order by id desc limit 1),
                        ('#{category.to_i}')
                    )
                ")
            end
        end

        true
    end

    def add_category(params)
        category = Category.new({
            name: params['category'],
            item: self
        })

        category.save
        true
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?
        true
    end

    def self.get_all_items_with_categories
        dbRaw = @@client.query("
            select items.*, categories.name as category_name, categories.id as category_id from items
            join item_categories on item_categories.item_id = items.id
            join categories on categories.id = item_categories.category_id
        ")
    
        items = Array.new
    
        dbRaw.each do | data |
            category = Category.new({
                :id     => data["category_id"],
                :name   => data["category_name"]
            })

            item = items.find{|h| h.id == data['id']}

            if item
                item.categories.push(category)
            else
                item = Item.new({
                    :id         => data["id"], 
                    :name       => data["name"], 
                    :price      => data["price"], 
                })

                item.categories.push(category)
                items.push(item)
            end

        end
    
        items
    end

    def self.get_all_items
        dbRaw = @@client.query("select * from items")
    
        items = Array.new
    
        dbRaw.each do |data|
            item = Item.new({
                :id     => data["id"],
                :name   => data["name"], 
                :price  => data["price"]
            })
            items.push(item)
        end
    
        items
    end

    def self.find_single_item(id)
        item = self.get_all_items_with_categories.find{|x| x.id == id}
    end

    def self.update_single_item(id, name, price, category_id)
        @@client.query("
            UPDATE items
            JOIN item_categories ON item_categories.item_id = '#{id}'
            SET 
                items.name = '#{name}',
                price = '#{price}',
                item_categories.category_id = '#{category_id}'
            WHERE id = '#{id}'
        ")
    end
    
    def self.delete_single_item(id)
        @@client.query("DELETE FROM items WHERE id = #{id}")
    end
end