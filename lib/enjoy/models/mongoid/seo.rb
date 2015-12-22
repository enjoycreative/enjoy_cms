module Enjoy
  module Models
    module Mongoid
      module Seo
        extend ActiveSupport::Concern
        include ::Mongoid::Paperclip
        included do

          field :name, type: String, localize: Enjoy.config.localize
          field :h1, type: String, localize: Enjoy.config.localize

          field :title, type: String, localize: Enjoy.config.localize
          field :keywords, type: String, localize: Enjoy.config.localize
          field :description, type: String, localize: Enjoy.config.localize
          field :robots, type: String, localize: Enjoy.config.localize

          field :og_title, type: String, localize: Enjoy.config.localize
          has_mongoid_attached_file :og_image, styles: {thumb: "800x600>"}
        end
      end
    end
  end
end
