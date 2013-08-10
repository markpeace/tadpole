Tadpole::Application.routes.draw do
 
  resources :inventories

	devise_for :users	
	root :to=>"brews#index"

    resources :brews
    post "/brew/:target_brew/importsteps"=>"steps#clone"
	get "/brews/:id/setdate"=>"brews#setdate"

	resources :steps
	post "/steps/:id/move/:direction"=>"steps#move"
	get "/steps/:id/complete"=>"steps#complete"
	
	get "user/:id/calendar"=>"calendar#index"

end
