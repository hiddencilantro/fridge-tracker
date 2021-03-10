class SessionsController < ApplicationController

    get '/login' do
        if logged_in?
            @error = "Hey #{current_user.firstname}, looks like you're already logged in! Sign out to log in with a different account."
            erb :'users/show'
        else
            erb :'sessions/login'
        end
    end

    post '/login' do
        if params[:username].empty? || params[:password].empty?
            @error = "Username and password cannot be blank."
            erb :'sessions/login'
        else
            if user = User.find_by_username(params[:username])
                if user.authenticate(params[:password])
                    session[:user_id] = user.id
                    redirect "/users/#{current_user.id}"
                else
                    @error = "Incorrect password. Please try again."
                    erb :'sessions/login'
                end
            else
                @error = "Username does not exist."
                erb :'sessions/login'
            end
        end
    end

    get '/logout' do
        session.clear
        redirect "/"
    end
end