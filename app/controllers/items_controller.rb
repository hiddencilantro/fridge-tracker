class ItemsController < ApplicationController

    # before do
    #     require_login
    # end

    get '/items' do #index
        redirect "/lists/#{session[:list_id]}"
        # redirect "/users/#{current_user.id}"
    end

    post '/items' do #create
        item = Item.new(params[:item])
        item.list_id = session[:list_id]
        item.save
        redirect "/lists/#{item.list_id}"
    end

    get '/items/:id/edit' do #edit // somehow redirects to '/login' without require_login
        check_for_authorization
        erb :'items/edit'
    end

    patch '/items/:id' do #update
        check_for_authorization
        @item.update(params[:item])
        redirect "/lists/#{@item.list_id}"
    end

    delete '/items/:id' do #destroy
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