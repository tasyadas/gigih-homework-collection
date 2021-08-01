require './models/item'
require './models/category'
require 'erb'

class ItemController
    def self.item_list
        items = Item.get_all_items
        renderer = ERB.new(File.read('./views/items/index.erb'))
        renderer.result(binding)
    end

    def self.show_item(id)
        item = Item.find_single_item(id.to_i)
        renderer = ERB.new(File.read('./views/items/show.erb'))
        renderer.result(binding)
    end

    def self.create_item
        categories = Category.get_all_categories
        renderer = ERB.new(File.read('./views/items/create.erb'))
        renderer.result(binding)
    end

    def self.add_item(req)
        item = Item.new(req)
        categories = req['categories']

        item.save(categories)
    end
end