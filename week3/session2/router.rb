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


# get '/items/edit/:id' do |id|
#     erb :edit, locals:{
#         item: find_single_item(id.to_i),
#         categories: get_all_categories
#     }
# end

# post '/items/update/:id' do |id|
#     name = params['name']
#     price = params['price']
#     category_id = params['category']
#     update_single_item(id.to_i, name, price.to_i, category_id.to_i)
#     redirect('/')
# end

# delete '/items/delete/:id' do |id|
#     delete_single_item(id.to_i)
#     redirect('/')
# end
