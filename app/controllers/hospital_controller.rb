class HospitalController < ApplicationController

      get '/hospitals' do
        redirect_if_not_logged_in
        #@hospitals = Hospital.all
        erb :'hospitals/hospitals'
      end

      get '/hospitals/new' do
        redirect_if_not_logged_in
        erb :'hospitals/create_hospital'  
      end

      post '/hospitals' do
        redirect_if_not_logged_in
        if params[:hospital_name] == "" || params[:hospital_country] == ""
          redirect to "/hospitals/new"
        else
          @user = User.find_by(id: session[:user_id])
          @hospital = Hospital.create(hospital_name: params[:hospital_name], hospital_country: params[:hospital_country], user_id: @user.id)
          @hospital.save
          redirect to "/hospitals/#{@hospital.id}"
        end
      end

      get '/hospitals/:id' do
        redirect_if_not_logged_in
        @hospital = Hospital.find_by_id(params[:id])
        @user = User.find_by(id: session[:user_id])
        if @hospital.user_id == @user.id 
          erb :'/hospitals/show_hospital' 
        else
          redirect to '/hospitals'
        end
      end

      get '/hospitals/:id/edit' do
        redirect_if_not_logged_in
        @hospital = Hospital.find_by_id(params[:id])
        @user = User.find_by(id: session[:user_id])
          if @hospital.user_id == @user.id 
            erb :'hospitals/edit_hospital'
          else
            redirect to '/hospitals'
          end
      end

      patch '/hospitals/:id' do 
        redirect_if_not_logged_in
        @hospital = Hospital.find(params[:id])
        @user = User.find_by(id: session[:user_id])
         if @hospital.user_id == @user.id && params[:hospital_name] != "" && params[:hospital_country] != ""
          @hospital.update(hospital_name: params[:hospital_name])
          @hospital.update(hospital_country: params[:hospital_country])
          redirect to "/hospitals/#{@hospital.id}"
         else
          redirect to "/hospitals/#{@hospital.id}/edit"
         end
      end
    
      delete '/hospitals/:id/delete' do
        redirect_if_not_logged_in
          @hospital = Hospital.find_by_id(params[:id])
          @hospital.destroy
          redirect to '/users/show'
      end
      
end