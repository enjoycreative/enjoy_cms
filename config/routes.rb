Enjoy::Engine.routes.draw do
  routes_config = Enjoy.configuration.routes_config

  
  get 'contacts' => 'contacts#new', as: :contacts
  post 'contacts' => 'contacts#create', as: :create_contacts
  get 'contacts/sent' => 'contacts#sent', as: :contacts_sent

  get 'search' => 'search#index', as: :search

  resources :news, only: [:index, :show]

  if routes_config and routes_config[:root_path]
    root to: routes_config[:root_path]
  end

  get '*slug' => 'pages#show'
  resources :pages, only: [:show]
end
