class ListsController < ApplicationController

    get '/lists' do #index
        erb :'lists/index'
    end
    
    get '/lists/new' do #new
        erb :'lists/new'
    end

    post '/lists' do #create
        list = List.new(params[:list])
        list.user_id = session[:user_id]
        list.save
        redirect "/lists/#{list.id}"
    end

    get '/lists/:id' do #show
        @list = List.find_by_id(params[:id])
        erb :'lists/show'
    end

end