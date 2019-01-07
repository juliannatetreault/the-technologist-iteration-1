class SessionsController < ApplicationController
    def new
    end

    def login
      @user = User.find_by(email: sessions_params[:email])
      if @user && user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        flash[:success] = "You have successfully logged in!"
       redirect_to user_path(@user)
      else 
        flash[:error] = "Oops! Invalid email or password. Please try again."
        redirect_to login_path
      end
    end 

    def github_auth
      auth = request.env["omniauth.auth"]     
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      #user.save     
      session[:user_id] = @user.id     
      redirect_to root_path
    end

    def logout
      #session.clear
      session[:user_id] = nil
      flash[:success] = "You have successfully logged out."
      redirect_to root_path
    end

    private 

    def session_params
      params.require(:session).permit(:email, :password)
    end

    def auth 
      request.env['omniauth.auth']
    end
end