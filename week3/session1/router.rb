require 'sinatra'
require './db_connector'

get '/' do
    items = get_all_items
    erb :index, locals:{
        items: items
    }
end

get '/items/:id' do |id|
    erb :show, locals:{
        item: find_single_item(id.to_i)
    }
end

get '/items/new' do
    erb :create
end

post '/items/create' do
    name = params['name']
    price = params['price']
    create_new_item(name, price)
    redirect('/')
end

get '/items/edit/:id' do |id|
    erb :edit, locals:{
        item: find_single_item(id.to_i),
        categories: get_all_categories
    }
end

post '/items/update/:id' do |id|
    name = params['name']
    price = params['price']
    category_id = params['category']
    update_single_item(id.to_i, name, price.to_i, category_id.to_i)
    redirect('/')
end

delete '/items/delete/:id' do |id|
    delete_single_item(id.to_i)
    redirect('/')
end
