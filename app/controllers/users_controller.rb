class UsersController < ApplicationController

    get "/signup" do  
        erb :"users/signup"
    end

    # get '/users/:slug' do 
    #     @user = User.find_by_slug(params[:slug])
    #     erb :"users/account"
    # end

    get '/account' do 
        if logged_in?
            @user = current_user
            erb :"users/account"
        end
    end
    
    post '/signup' do
        @user = User.new(params)
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
          redirect '/signup'
        end
        if @user.save
          session[:user_id] = @user.id
          redirect '/account'
        end
    end
         
    get "/login" do 
        if logged_in?
            redirect '/account'
        else
            erb :"users/login"
        end
    end
    
    post "/login" do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/account'
        else
            redirect '/login'
        end
    end

    get "/logout" do 
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end
end

