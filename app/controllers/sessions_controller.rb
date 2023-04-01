class SessionsController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:create]
    def create
        user=User.find_by(username: params[:username])
        if user &.authenticate(params[:password])
            session[:user_id]=user.id
            render json: user, status: :created
        else
          
            render json: {errors: ["Wrong password or username"]}, status: 401
        end
    end
    def destroy
        session.delete :user_id
        head :no_content
    end
    def authorize
        render json: {errors: ["Not authorized"]}, status: 401 unless session.include? :user_id
    end
end
