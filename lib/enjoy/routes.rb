module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_routes(config = {})
      routes_config = {
        root_path: "home#index"
      }
      routes_config.merge!(config)

      scope module: 'enjoy' do

        if routes_config[:root_path]
          root to: routes_config[:root_path]
        end
      end

    end

  end
end
