module Enjoy
  class HomeController < ApplicationController

    def index
      render layout: Enjoy.config.main_index_layout
    end

    include Enjoy::Decorators::Home
  end
end
