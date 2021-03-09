class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id]
            "Looks like you're already logged in! Click here to return to your page or here to logout."
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        user = User.create(params[:user])
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
    end

    get '/users/:id' do
        @user = User.find_by_id(params[:id])
        erb :'users/show'
    end
end