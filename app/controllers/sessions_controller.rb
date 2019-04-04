class SessionsController < ApplicationController
  def create
  	success, user = User.valid_login?(params[:email], params[:password])

    if success
      render json: user.as_json(only: [:id, :email]), status: :created  
    else
      head :unauthorized
    end
  end

  def destroy
  end
end
