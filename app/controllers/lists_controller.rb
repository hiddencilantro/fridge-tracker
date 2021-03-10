class ListsController < ApplicationController

    before do
        require_login
    end

    get '/lists' do #index
        redirect "/users/#{current_user.id}"
    end
    
    get '/lists/new' do #new
        erb :'lists/new'
    end

    post '/lists' do #create
        list = List.new(params[:list])
        list.user_id = current_user.id
        if list.save
            redirect "/lists/#{list.id}"
        else
            @error = "All fields are required."
            erb :'lists/new'
        end
    end

    get '/lists/:id' do #show
        check_for_authorization
        session[:list_id] = @list.id

        @error = session[:error]
        session.delete(:error)

        erb :'lists/show'
    end

    get '/lists/:id/edit' do #edit
        check_for_authorization
        erb :'lists/edit'
    end

    patch '/lists/:id' do #update
        check_for_authorization
        if @list.update(params[:list])
            redirect "/users/#{current_user.id}"
        else
            @error = "Title cannot be blank."
            erb :'lists/edit'
        end
    end

    delete '/lists/:id' do #destroy
        check_for_authorization
        @list.destroy
        redirect "/users/#{current_user.id}"
    end

    private

    def check_for_authorization
        @list = List.find_by_id(params[:id])
        redirect back if @list == nil || @list.user != current_user
    end

end