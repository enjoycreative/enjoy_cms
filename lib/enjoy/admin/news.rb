module Enjoy
  module Admin
    module News
      def self.config(fields = {})
        Proc.new {
          # navigation_label I18n.t('enjoy.cms')
          list do
            scopes [:by_date, :enabled, nil]
          end

          field :enabled, :toggle
          field :time do
            sort_reverse true
          end
          field :name
          unless Enjoy.config.news_image_styles.nil?
            field :image, :jcrop do
              jcrop_options :image_jcrop_options
            end
          end
          field :excerpt, :enjoy_html
          field :slugs, :enum do
            enum_method do
              :slugs
            end
            visible do
              bindings[:view].current_user.admin?
            end
            multiple do
              true
            end
          end
          field :text_slug

          list do
            sort_by :time
          end

          edit do
            field :content, :enjoy_html
            fields.each_pair do |name, type|
              if type.nil?
                field name
              else
                if type.is_a?(Array)
                  field name, type[0], &type[1]
                else
                  field name, type
                end
              end
            end

            group :seo do
              active false
              field :seo do
                active true
              end
            end
            group :sitemap_data do
              active false
              field :sitemap_data do
                active true
              end
            end
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
