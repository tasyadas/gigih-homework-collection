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
        item.save
    end

    def self.edit_item(id)
        item = Item.find_single_item(id.to_i)
        categories = Category.get_all_categories
        renderer = ERB.new(File.read('./views/items/edit.erb'))
        renderer.result(binding)
    end

    def self.update_item(req)
        item = Item.new(req)
        item.update_single_item
    end

    def self.destroy(id)
        item = Item.find_single_item(id.to_i)
        item.delete_single_item
    end
end