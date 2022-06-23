class SportsController < ApplicationController

    get '/register' do 
        if logged_in?
            erb :"sports/register"
        else
            redirect '/login'
        end
    end

    post '/register' do 
        @sport = Sport.new(params)
        @sport.user_id = session[:user_id]
        @sport.save
        redirect "/sports/#{@sport.id}"
    end

    get '/sports/:id' do 
        get_sport
        erb :"sports/reg_complete"
    end

    get '/sports/:id/edit' do 
        get_sport
        redirect_if_not_authorized
        if @sport.user == current_user 
            erb :"/sports/edit"
        end
    end

    patch '/sports/:id' do 
        get_sport
        redirect_if_not_authorized
        @sport.update(sport: params[:sport], age: params[:age], skill_level: params[:skill_level])
        redirect "/sports/#{@sport.id}"
    end

    delete '/sports/:id' do 
        get_sport
        @sport.destroy
        redirect '/account'
    end

    private 

        def get_sport
            @sport = Sport.find_by(id: params[:id])
        end

        def redirect_if_not_authorized
            if @sport.user != current_user
                redirect '/account'
            end 
        end 

end