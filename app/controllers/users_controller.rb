class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            "Looks like you're already logged in! Click here to return to your page or here to logout."
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