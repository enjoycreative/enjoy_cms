module Enjoy
  class PagesController < ApplicationController
    include Enjoy::Controllers::Pages

    include Enjoy::Decorators::Pages
  end
end
