class ListsController < ApplicationController

    get '/lists' do #index
        redirect "/users/#{session[:user_id]}"
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
        session[:list_id] = @list.id
        erb :'lists/show'
    end

    delete '/lists/:id' do #delete
        list = List.find_by_id(params[:id])
        list.destroy
        redirect "/users/#{list.user_id}"
    end

end