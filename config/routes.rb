Rails.application.routes.draw do
  
	namespace :api do
    namespace :v1, defaults: { format: :json } do
		  get 'transactions/transfer'
		  get 'transactions/balance'
		  devise_for :users, controllers: { sessions: 'sessions'}
		end
	end
end
