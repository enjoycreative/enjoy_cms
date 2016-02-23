module Enjoy
  module Models
    module Mongoid
      module PageBlock
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          has_and_belongs_to_many :blocksets, inverse_of: :blocks, class_name: "Enjoy::PageBlockset"

          enjoy_cms_html_field :content, type: String, localize: Enjoy.config.localize, default: ""
        end
      end
    end
  end
end
