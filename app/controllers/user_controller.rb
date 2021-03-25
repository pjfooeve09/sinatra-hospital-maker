class UserController < ApplicationController

    get '/signup' do
      redirect to '/hospitals' if logged_in?
      erb :'users/create_user'
    end
  
    post '/signup' do
      if params[:username] == '' || params[:password] == '' || params[:email] == ''
        redirect to '/signup'
      else
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/hospitals'
      end
    end

    get '/login' do
      if logged_in?
          redirect '/hospitals'
      else
          erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(:username => params[:username])
      if !!@user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/hospitals'
      else
        redirect to '/signup'
      end
    end

    get '/users/show' do  
      erb :'users/show'
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      end
    end
    
end

