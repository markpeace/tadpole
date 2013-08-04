Tadpole::Application.routes.draw do
  resources :brews

	devise_for :users	
	root :to=>"brews#index"

end
