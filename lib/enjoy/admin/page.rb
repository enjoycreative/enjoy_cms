module Enjoy
  module Admin
    module Page
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enableable
      include Seoable
      include ManualSlug
      include SitemapData

      include Enjoy.orm_specific('Page')

      if Enjoy.config.search_enabled
        include Enjoy::ElasticSearch
      end

      included do

        has_and_belongs_to_many :menus, inverse_of: :pages, class_name: "Enjoy::Menu"
        validates_uniqueness_of :fullpath
        validates_presence_of :name
        manual_slug :name
        before_validation do
          self.fullpath = "/pages/#{slug}" if self.fullpath.blank?
        end
      end

      def get_fullpath
        redirect.blank? ? fullpath : redirect
      end

      def has_content?
        @content_used.nil? && !content.blank?
      end

      def page_content
        if @content_used.nil?
          @content_used = true
          if content.nil?
            ''
          else
            content.gsub(/\{\{(.*?)\}\}/) do
              Settings ? Settings.get($1).val : "" #temp
            end
          end
        else
          ''
        end
      end

      def is_current?(url)
        if fullpath == '/'
          url == '/'
        else
          url.match(clean_regexp)
        end
      end

      def regexp_prefix
        ""
      end

      def clean_regexp
        if regexp.blank?
          /^#{regexp_prefix}#{Regexp.escape(fullpath)}$/
        else
          begin
            /#{regexp}/
          rescue
            # not a valid regexp - treat as literal search string
            /#{Regexp.escape(regexp)}/
          end
        end
      end

      def nav_options
        {highlights_on: clean_regexp}
      end
    end
  end
end
