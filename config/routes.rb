Rails.application.routes.draw do
  
	namespace :api do
    namespace :v1, defaults: { format: :json } do
		  post 'transactions/transfer'
		  get 'transactions/balance'
		end
	end
  devise_for :users, controllers: { sessions: 'sessions'}
end
