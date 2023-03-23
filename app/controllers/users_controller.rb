class UsersController < ApplicationController
    def show
        user = User.find_by(id: session[:user_id])

        if user
            render json: user
        else
            render json: {error: "Not logged in"}, status: :unauthorized

        end
    end
end