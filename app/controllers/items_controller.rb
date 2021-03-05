class ItemsController < ApplicationController

    post '/items' do
        item = Item.new(params[:item])
        item.list_id = session[:list_id]
        item.save
        redirect "/lists/#{item.list_id}"
    end
end