class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            "Looks like you're already logged in! Click here to return to your page or here to logout."
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        user = User.create(params[:user])
        session[:user_id] = user.id
        redirect "/users/#{current_user.id}"
    end

    get '/users/:id' do
        require_login
        erb :'users/show'
    end
end