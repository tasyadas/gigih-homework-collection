require 'sinatra'

$items = []

get '/items' do
    erb :add_item
end

post '/add-item' do
    $items << params['item']
end

get '/item-list' do
    for i in $items
        i + "<br>"
    end
end