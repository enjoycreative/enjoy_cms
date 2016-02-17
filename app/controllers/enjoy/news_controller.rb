module Enjoy
  class NewsController < ApplicationController
    include Enjoy::Controllers::News

    include Enjoy::Decorators::News
  end
end
