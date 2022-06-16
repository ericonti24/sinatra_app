class SportsController < ApplicationController

    get '/register' do 
        if logged_in?
            erb :"sports/register"
        else
            redirect '/login'
        end
    end

    post '/register' do 
        
        # @user = current_user
        # binding.pry
        # if params[:sport].blank? && params[:age].blank? && params[:skill_level].blank?
        #     redirect "/register"
        # else
        #     @sport = @user.sports.new(params)
        #     @user.save
        #     redirect "/sports/#{@sport.id}"
        # end
        @sport = Sport.new(params)
        @sport.user_id = session[:user_id]
        @sport.save
        redirect "/sports/#{@sport.id}"
    end



    get '/sports/:id' do 
        # @sport = Sport.find_by(id: params[:id])
        get_sport
        # binding.pry
        # if logged_in?
        #     erb :"sports/reg_complete"
        # else
        #     redirect '/login'
        # end
        erb :"sports/reg_complete"
    end

    get '/sports/:id/edit' do 
        # @sport = Sport.find_by(id: params[:id])
        get_sport
        if @sport.user == current_user #if current user is logged in render edit form
            erb :"/sports/edit"
        end
    end

    patch '/sports/:id' do 
        # @sport = Sport.find_by_id(params[:id])
        get_sport
        redirect_if_not_authorized
        @sport.update(sport: params[:sport], age: params[:age], skill_level: params[:skill_level])
        # redirect "/sports/#{@sport.id}"
        redirect "/account"
    end

    private 

        def get_sport
            @sport = Sport.find_by(id: params[:id])
        end

        def redirect_if_not_authorized
            if @post.author != current_user
                flash[:error] = "You cant make this edit, you don't own this"
                redirect '/posts'
            end 
        end 

end