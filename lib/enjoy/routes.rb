module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_routes(config = {})
      routes_config = {
        use_contacts_path: true,
        use_search_path: true,
        use_news_path: true,
        root_path: "home#index",
        use_slug_path: true,
        use_pages_path: true
      }
      routes_config.merge!(config)

      scope module: 'enjoy' do
        if routes_config[:use_contacts_path]
          get 'contacts' => 'contacts#new', as: :enjoy_contacts
          post 'contacts' => 'contacts#create', as: :create_enjoy_contacts
          get 'contacts/sent' => 'contacts#sent', as: :enjoy_contacts_sent
        end

        if routes_config[:use_search_path]
          get 'search' => 'search#index', as: :enjoy_search
        end

        if routes_config[:use_news_path]
          resources :news, only: [:index, :show], as: :enjoy_news
        end

        if routes_config[:root_path]
          root to: routes_config[:root_path]
        end

        if routes_config[:use_slug_path]
          get '*slug' => 'pages#show'
        end
        if routes_config[:use_pages_path]
          resources :pages, only: [:show], as: :enjoy_pages
        end
      end

    end

  end
end
