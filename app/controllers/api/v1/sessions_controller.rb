class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
		user = User.where(email: params[:email]).first
		if user&.valid_password?(params[:password])
		 	render json: user.as_json(only: [:email, :authentication_token]), status: :created  
		else
		 	head :unauthorized
		end
  end

  def destroy

  end

  #private
#
  #def respond_with(resource, _opts = {})
  #  render json: resource
  #end
#
  #def respond_to_on_destroy
  #  head :no_content
  #end
end
