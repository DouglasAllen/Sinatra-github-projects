require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/items')
require('./lib/purchases')
require('pg')

get('/') do
  @items = Item.all()
  erb(:index)
end

post('/items') do
  erb(:index)
end

patch('/purchases') do
  item_ids = params.fetch("item_ids")
  @purchase = Purchase.new()
  @purchase.update({:item_ids => item_ids})
  erb(:purchases)
end

get('/manager') do
  @items = Item.all()
  erb(:manager)
end

post('/manager') do
  @items = Item.all()
  item_name = params.fetch("item_name")
  item_price = params.fetch("item_price")
  Item.new({:name => item_name, :price => item_price}).save()
  erb(:manager)
end

delete('/manager') do
  @items = Item.all()
  item_id = params.fetch("item_id").to_i()
  Item.find(item_id).delete()
  erb(:manager)
end

patch('/manager') do
  @items = Item.all()
  item_id = params.fetch("item_id").to_i()
  item_name = params.fetch("item_name")
  item_price = params.fetch("item_price")
  @item = Item.find(item_id)
  @item.update({:name => item_name, :price => item_price})
  erb(:manager)
end
