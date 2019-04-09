Rails.application.routes.draw do
  devise_for :users
	namespace :api do
    namespace :v1, defaults: { format: :json } do
		  post 'transactions/transfer'
		  get 'transactions/balance'
		  resources :sessions, only: [:create, :destroy]
		end
	end
end
