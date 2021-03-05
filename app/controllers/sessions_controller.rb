class SessionsController < ApplicationController

    get '/signup' do
        erb :'sessions/signup'
    end

    post '/signup' do
        user = User.create(params[:user])
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
    end

    get '/login' do
        
    end

    post '/login' do

    end

    get '/logout' do
        session.clear
        redirect "/"
    end
end