class HospitalController < ApplicationController

      get '/hospitals' do 
        redirect_if_not_logged_in 
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
          @hospital = Hospital.create(hospital_name: params[:hospital_name], hospital_country: params[:hospital_country], user_id: current_user.id)
          @hospital.save
          redirect to "/hospitals/#{@hospital.id}"
        end
      end

      get '/hospitals/:id' do
        redirect_if_not_logged_in
        if hospital.user_id == current_user.id 
          erb :'/hospitals/show_hospital' 
        else
          redirect to '/hospitals'
        end
      end

      get '/hospitals/:id/edit' do
        redirect_if_not_logged_in
          if hospital.user_id == current_user.id 
            erb :'hospitals/edit_hospital'
          else
            redirect to '/hospitals'
          end
      end

      patch '/hospitals/:id' do 
        redirect_if_not_logged_in
         if hospital.user_id == current_user.id && params[:hospital_name] != "" && params[:hospital_country] != ""
          hospital.update(hospital_name: params[:hospital_name])
          hospital.update(hospital_country: params[:hospital_country])
          redirect to "/hospitals/#{hospital.id}"
         else
          redirect to "/hospitals/#{hospital.id}/edit"
         end
      end
    
      delete '/hospitals/:id/delete' do
        redirect_if_not_logged_in
          hospital.destroy
          redirect to '/users/show'
      end
      
end