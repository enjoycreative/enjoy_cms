#todo multimodelsearch
module Enjoy
  class SearchController < ApplicationController
    include Enjoy::Controllers::Search

    include Enjoy::Decorators::Search
  end
end
