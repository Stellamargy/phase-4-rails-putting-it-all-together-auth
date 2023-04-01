class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
    def create
        user=User.create!(user_params)
        puts user.valid?
            session[:user_id]=user.id
            render json: user, status: :created
    end
    def show
        user = User.find_by(id: session[:user_id])
        if user 
            render json: user
        else
            render json: {error: "No user is logged in"}, status: 401
        end
        end
    
    private
    def user_params
        params.permit(:username, :password, :image_url, :bio, :password_confirmation)
    end

    def unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
