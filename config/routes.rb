Tadpole::Application.routes.draw do
  resources :brews

	devise_for :users
	
	root :to=>"splash#index"

end
