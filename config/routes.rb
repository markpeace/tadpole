Tadpole::Application.routes.draw do

	devise_for :users	
	root :to=>"brews#index"

    resources :brews
    post "/brew/:target_brew/importsteps"=>"steps#clone"
	get "/brews/:id/setdate"=>"brews#setdate"

	resources :steps
	post "/steps/:id/move/:direction"=>"steps#move"
	get "/steps/:id/complete"=>"steps#complete"
	
	get "user/:id/calendar"=>"calendar#index"
	
	get "/inventories/shoppinglist/:brewdate"=>"inventories#shoppinglist"
	post "/inventories/shoppinglist/:brewdate"=>"inventories#shoppinglist"
	resources :inventories

end
