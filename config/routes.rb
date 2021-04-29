Rails.application.routes.draw do

  namespace :admins_backoffice do
       get 'welcome/index'
       #resources :admins, only: %i[ index edit update new create]
       resources :admins#, except: :destroy
    # get 'admins/index'
    # get 'admins/edit/:id', to: 'admins#edit'
  end
	namespace :site do
			get 'welcome/index'
	end
	namespace :users_backoffice do
			get 'welcome/index'
	end
	
	devise_for :admins
	devise_for :users
	
	get   'start', to: 'site/welcome#index'
	root  'site/welcome#index'

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
