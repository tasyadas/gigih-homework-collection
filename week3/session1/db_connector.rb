require 'mysql2'
require './item'
require './category'

def create_db_client
    client = Mysql2::Client.new(
        :host     => "localhost",
        :username => "root",
        :password => "tasyadas",
        :database => "db_yabb_latihan"
    )

    client
end

$client = create_db_client

def get_all_items
    dbRaw = $client.query("select * from items")

    items = Array.new

    dbRaw.each do |data|
        item = Item.new(data['name'], data['price'], data['id'])
        items.push(item)
    end

    items
end

def get_all_categories
    dbRaw = $client.query("select * from categories")

    categories = Array.new

    dbRaw.each do |data|
        category = Category.new(data['name'], data['id'])
        categories.push(category)
    end

    categories
end

def get_all_items_with_categories
    dbRaw = item_categories = $client.query("
        select items.*, categories.name as category_name, categories.id as category_id from items
        join item_categories on item_categories.item_id = items.id
        join categories on categories.id = item_categories.category_id
    ")

    items = Array.new

    dbRaw.each do | data |
        category = Category.new(data["category_name"], data["category_id"])
        item = Item.new(data["name"], data["price"], data["id"], category)
        items.push(item)
    end

    items
end

def create_new_item(name, price)
    $client.query("insert into items(name, price) values('#{name}', '#{price}')")
end

def find_single_item(id)
    item = get_all_items_with_categories.find{|x| x.id == id}
end

def update_single_item(id, name, price, category_id)
    $client.query("
        UPDATE items
        JOIN item_categories ON item_categories.item_id = '#{id}'
        SET 
            items.name = '#{name}',
            price = '#{price}',
            item_categories.category_id = '#{category_id}'
        WHERE id = '#{id}'
    ")
end

def delete_single_item(id)
    $client.query("DELETE FROM items WHERE id = #{id}")
end

# items = get_all_items
# categories = get_all_categories
# item_categories = find_single_item(1)

# item_categories.each do | item |
#     puts(item.name)
# end