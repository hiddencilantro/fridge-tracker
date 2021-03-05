require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "849b00e9e5bc8a20f38e5450b02a74d8aa141cf12b5c09aa9b13272eeb00e49c"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

end
