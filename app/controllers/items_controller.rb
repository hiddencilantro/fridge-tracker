class ItemsController < ApplicationController

    post '/items' do
        item = Item.new(params[:item])
        item.list_id = session[:list_id]
        item.save
        redirect "/lists/#{item.list_id}"
    end

    get '/items/:id/edit' do
        @item = Item.find_by_id(params[:id])
        erb :'items/edit'
    end

    patch '/items/:id' do
        item = Item.find_by_id(params[:id])
        item.update(params[:item])
        redirect "/lists/#{item.list_id}"
    end

    delete '/items/:id' do
        item = Item.find_by_id(params[:id])
        item.destroy
        redirect "/lists/#{item.list_id}"
    end
end