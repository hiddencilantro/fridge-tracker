class ItemsController < ApplicationController

    # before do
    #     require_login
    # end

    get '/items' do #INDEX (/lists/:id SHOW)
        redirect back #(?)redirects to user SHOW page rather than previous page
    end

    post '/items' do #CREATE
        item = Item.new(params[:item])
        item.list_id = session[:list_id]
        if item.save
            redirect "/lists/#{item.list_id}"
        else
            session[:error] = "All fields are required."
            redirect "/lists/#{item.list_id}"
        end
    end

    get '/items/:id/edit' do #EDIT // (?)redirects to '/login' without require_login
        check_for_authorization
        erb :'items/edit'
    end

    patch '/items/:id' do #UPDATE
        check_for_authorization
        @item.update(params[:item])
        redirect "/lists/#{@item.list_id}"
    end

    delete '/items/:id' do #DESTROY
        check_for_authorization
        @item.destroy
        redirect "/lists/#{@item.list_id}"
    end

    private

    def check_for_authorization
        @item = Item.find_by_id(params[:id])
        redirect back if @item == nil || !current_user.lists.include?(@item.list)
    end

end