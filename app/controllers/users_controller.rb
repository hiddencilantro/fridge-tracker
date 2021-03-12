class UsersController < ApplicationController

    get '/signup' do #NEW (/users/new)
        if logged_in?
            @error = "You must first sign out to register a new account."
            erb :'users/show'
        else
            erb :'users/new'
        end
    end

    post '/users' do #CREATE
        user = User.new(params[:user])
        if user.save
            session[:user_id] = user.id
            redirect "/users/#{current_user.id}"
        else
            @error = "All fields required. Username must be unique."
            erb :'users/new'
        end
    end

    get '/users/:id' do #SHOW (/list INDEX)
        require_login
        erb :'users/show'
    end

    get '/users/:id/profile' do #SHOW
        require_login

        @message = session[:message]
        session.delete(:message)

        erb :'users/profile'
    end

    get '/users/:id/profile/edit' do #EDIT
        require_login
        erb :'users/edit'
    end

    patch '/users/:id/profile' do #UPDATE
        current_user.skip_validations = true
        if current_user.update(params[:user])
            session[:message] = "Profile successfully updated!"
            redirect "/users/#{current_user.id}/profile"
        else
            @error = "All fields required. Username must be unique."
            erb :'users/edit'
        end
    end

    get '/users/:id/delete' do
        require_login
        erb :'users/delete'
    end

    delete '/users/:id' do #DESTROY
        current_user.destroy
        redirect "/"
    end

    get '/users/:id/profile/password' do
        erb :'users/password'
    end

    patch '/users/:id/profile/password' do
        if params[:password].empty? || params[:old_password].empty? || params[:confirm_password].empty?
            @error = "All fields are required to change your password."
            erb :'users/password'
        else
            if current_user.authenticate(params[:old_password]) && params[:password] == params[:confirm_password]
                current_user.update(password: params[:password])
                session[:message] = "Password successfully updated!"
                redirect "/users/#{current_user.id}/profile"
            else
                @error = "Invalid entry."
                erb :'users/password'
            end
        end
    end

end