Tadpole::Application.routes.draw do
  
  resources :brews

	devise_for :users	
	root :to=>"brews#index"

	resources :steps
	post "/steps/:id/move/:direction"=>"steps#move"

end
