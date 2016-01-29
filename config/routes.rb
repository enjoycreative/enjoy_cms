Enjoy::Engine.routes.draw do
  routes_config = Enjoy.configuration.routes_config

  if !routes_config or routes_config[:use_contacts_path]
    get 'contacts' => 'contacts#new', as: :contacts
    post 'contacts' => 'contacts#create', as: :create_contacts
    get 'contacts/sent' => 'contacts#sent', as: :contacts_sent
  end

  if !routes_config or routes_config[:use_search_path]
    get 'search' => 'search#index', as: :search
  end

  if !routes_config or routes_config[:use_news_path]
    resources :news, only: [:index, :show]
  end

  if routes_config and routes_config[:root_path]
    root to: routes_config[:root_path]
  end

  if !routes_config or routes_config[:use_slug_path]
    get '*slug' => 'pages#show'
  end
  if !routes_config or routes_config[:use_pages_path]
    resources :pages, only: [:show]
  end
end
