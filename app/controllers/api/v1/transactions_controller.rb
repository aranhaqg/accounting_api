class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_user!
  def transfer
  	begin
  		if params[:source_account_id].present? && params[:destination_account_id].present? && params[:amount].present?
  			Transaction.transfer(params[:source_account_id], params[:destination_account_id], BigDecimal.new(params[:amount]))
  			render json: {message: I18n.t('messages.success')}, status: :ok
  		else
  			render json: {error: I18n.t('errors.missing_params')}, status: :bad_request
  		end
  	rescue Exception => e
  		render json: {error: e.message}, status: :unprocessable_entity 
  	end
  	
  end

  def balance
  	begin
  		if params[:id].present? 
  			account = Account.find params[:id]
				render json: {balance: account.balance}, status: :ok
  		else
  			render json: {error: I18n.t('errors.missing_params')}, status: :bad_request
  		end
  	rescue Exception => e
  		render json: {error: I18n.t('errors.source_account_not_found')}, status: :unprocessable_entity
  	end
  end

end
