module Enjoy
  module Models
    module Mongoid
      module PageBlock
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          enjoy_cms_html_field :content, type: String, localize: Enjoy.config.localize, default: ""
        end
      end
    end
  end
end
