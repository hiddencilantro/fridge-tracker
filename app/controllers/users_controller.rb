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
            @error = "All fields required. Username must be unique."
            erb :'users/signup'
        end
    end

    get '/users/:id' do
        require_login
        erb :'users/show'
    end

    get '/users/:id/profile' do
        require_login
        erb :'users/profile'
    end

    get '/users/:id/profile/edit' do
        require_login
        erb :'users/edit'
    end

    patch '/users/:id/profile' do
        current_user.skip_validations = true
        if current_user.update(params[:user])
            redirect "/users/#{current_user.id}/profile"
        else
            @error = "All fields required. Username must be unique."
            erb :'users/edit'
        end
    end

    delete '/users/:id' do
        current_user.destroy
        redirect "/"
    end

end