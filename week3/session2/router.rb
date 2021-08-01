require 'sinatra'
require './controllers/item_controller'

get '/' do
    ItemController.item_list
end

get '/items/new' do
    ItemController.create_item
end

post '/items/create' do
    ItemController.add_item(params)
    redirect('/')
end

get '/items/:id' do |id|
    ItemController.show_item(id)
end


get '/items/edit/:id' do |id|
    ItemController.edit_item(id)
end

post '/items/update/:id' do
    ItemController.update_item(params)
    redirect('/')
end

delete '/items/delete/:id' do |id|
    ItemController.destroy(id)
    redirect('/')
end
