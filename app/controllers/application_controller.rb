class ApplicationController < ActionController::API
	acts_as_token_authentication_handler_for User, fallback: :none

	def check_token_expiration
		if current_user.token_expired? 
			current_user.token_expires_at = nil
			current_user.authentication_token = nil
			current_user.save
			render json: {error: I18n.t('errors.token_expired')}, status: :unauthorized
		end
	end
end
