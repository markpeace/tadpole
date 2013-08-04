Tadpole::Application.routes.draw do
	devise_for :users
	
	root :to=>"splash#index"

end
