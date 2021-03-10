class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            @error = "You must first sign out to register a new account."
            erb :'users/show'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        user = User.new(params[:user])
        if user.save
            session[:user_id] = user.id
            redirect "/users/#{current_user.id}"
        else
            @error = "Invalid entry."
            erb :'users/signup'
        end
    end

    get '/users/:id' do
        require_login
        erb :'users/show'
    end
end