Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/search_locations' => 'search_locations#show', via: :get
  match '/search_locations/:query' => 'search_locations#show', via: :get
end
