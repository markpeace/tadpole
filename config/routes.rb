Tadpole::Application.routes.draw do
  

	devise_for :users	
	root :to=>"brews#index"

    resources :brews
    post "/brew/:target_brew/importsteps"=>"steps#clone"

	resources :steps
	post "/steps/:id/move/:direction"=>"steps#move"

end
