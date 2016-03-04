module Enjoy
  module Models
    module Mongoid
      module Page
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          if defined?(RailsAdminComments)
            include RailsAdminComments::Commentable
          end

          belongs_to :connectable, polymorphic: true
          scope :connected, -> {
            where(:connectable_id.ne => nil)
          }
          scope :unconnected, -> (except_this = nil) {
            if except_this
              where({"$or" =>[
                {:connectable_id => nil},
                {"$and" => [
                  {connectable_type: except_this.class.to_param},
                  {connectable_id: except_this._id}
                ]}
              ]})
            else
              where(:connectable_id => nil)
            end
          }

          field :name, type: String, localize: Enjoy.config.localize, default: ""

          field :regexp, type: String, default: ""
          field :redirect, type: String, default: ""
          enjoy_cms_html_field :excerpt, type: String, localize: Enjoy.config.localize, default: ""
          enjoy_cms_html_field :content, type: String, localize: Enjoy.config.localize, default: ""
          field :fullpath, type: String, default: ""

          has_and_belongs_to_many :menus, inverse_of: :pages, class_name: "Enjoy::Menu"
          acts_as_nested_set

          scope :sorted, -> { order_by([:lft, :asc]) }
          scope :menu, ->(menu_id) { enabled.sorted.where(menu_ids: menu_id) }
        end
      end
    end
  end
end
