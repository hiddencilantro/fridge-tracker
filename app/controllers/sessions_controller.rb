class SessionsController < ApplicationController

    get '/login' do
        if logged_in?
            redirect "/users/#{current_user.id}"
        else
            erb :'users/login'
        end
    end

    post '/login' do
        if params[:username].empty? || params[:password].empty?
            @error = "Username and password cannot be blank."
            erb :'users/login'
        else
            if user = User.find_by_username(params[:username])
                if user.authenticate(params[:password])
                    session[:user_id] = user.id
                    redirect "/users/#{current_user.id}"
                else
                    @error = "Incorrect password. Please try again."
                    erb :'users/login'
                end
            else
                @error = "Username does not exist."
                erb :'users/login'
            end
        end
    end

    get '/logout' do
        session.clear
        redirect "/"
    end
end