module Enjoy
  class HomeController < ApplicationController

    def index
    end

    include Enjoy::Decorators::Home
  end
end
