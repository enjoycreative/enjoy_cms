module Enjoy
  module Models
    module News
      extend ActiveSupport::Concern
      include Enjoy::Model
      include ManualSlug
      include Enjoy::Seoable
      include Enjoy::Enableable
      include Enjoy::SitemapDataField
      include Enjoy::Connectable

      include Enjoy.orm_specific('News')

      # if Enjoy.config.search_enabled
      #   include Enjoy::ElasticSearch
      # end

      included do
        enjoy_connectable_field :connected_pages, routes_namespace: :enjoy_cms

        unless Enjoy.config.news_image_styles.nil?
          validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/, if: :image?
        end

        validates_presence_of :name
        if Enjoy.config.news_content_required
          validates_presence_of :content_html
        end

        before_validation do
          self.time = Time.now if self.time.blank?
        end
        scope :recent, ->(count = 5) { enabled.after_now.by_date.limit(count) }
        unless Enjoy.config.news_per_page.nil?
          paginates_per Enjoy.config.news_per_page
        end
        smart_excerpt :excerpt, :content, Enjoy.config.news_excerpt
        manual_slug :report_slug
      end

      def report_slug
        if time.blank?
          name
        elsif name.blank?
          time.strftime('%Y-%m-%d')
        else
          time.strftime('%Y-%m-%d') + '-' + name[0..20]
        end
      end
      def html5_date
        time.strftime('%Y-%m-%d')
      end
      def format_date
        time.strftime(I18n.t('Enjoy.format_time'))
      end
    end
  end
end
