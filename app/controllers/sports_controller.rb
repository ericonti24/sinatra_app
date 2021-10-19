class SportsController < ApplicationController

    get '/register' do 
        if logged_in?
            erb :"sports/register"
        else
            redirect '/login'
        end
    end

    get '/sports/:id' do 
        @sport = Sport.find(params[:id])
        if logged_in?
            erb :"sports/reg_complete"
        else
            redirect '/login'
        end
    end

    post '/register' do 
        
        @user = current_user
        if params[:sport].blank? && params[:age].blank? && params[:skill_level].blank?
            redirect "/register"
        else
            @sport = @user.sports.build(params)
            @user.save
            redirect "/sports/#{@sport.id}"
        end
    end


    

end