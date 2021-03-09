class SessionsController < ApplicationController

    get '/login' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by_username(params[:username])
        if user
            if user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect "/users/#{user.id}"
            else
                "Password did not match. Please try again."
            end
        else
            "Username does not exist"
        end
    end

    get '/logout' do
        session.clear
        redirect "/"
    end
end