class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
		user = User.where(email: params[:email]).first
		if user&.valid_password?(params[:password])
      user.update(token_expires_at: DateTime.now + ENV['TOKEN_EXPIRATION_TIME'].to_i.minutes)
		 	render json: user.as_json(only: [:email, :authentication_token]), status: :created  
		else
		 	head :unauthorized
		end
  end

  def destroy
    current_user.token_expires_at = nil
    if current_user.save
      head :ok
    else
      head :unauthorized
    end
  end
end
