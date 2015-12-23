module Enjoy
  class << self
    def map_config(is_active = true)
      Proc.new {
        active is_active
        label I18n.t('rs.map')
        field :address, :string
        field :map_address, :string
        field :map_hint, :string
        field :coordinates, :string do
          read_only true
          formatted_value{ bindings[:object].coordinates.to_json }
        end
        field :lat
        field :lon

        if block_given?
          yield
        end
      }
    end

    def seo_config(is_active = true)
      Proc.new {
        if respond_to?(:active)
          active is_active
          label "SEO"
        else
          visible false
        end
        Enjoy.seo_fields(self)
      }
    end

    def seo_fields(s)
      s.instance_eval do
        field :h1, :string
        field :title, :string
        field :keywords, :text
        field :description, :text
        field :robots, :string

        field :og_title, :string

        field :og_image, :jcrop do
          jcrop_options :og_image_jcrop_options
        end

        if block_given?
          yield
        end
      end
    end

    def page_config(fields = {})
      Proc.new {
        Enjoy.apply_patches self
        # navigation_label I18n.t('rs.cms')
        list do
          scopes [:sorted, :enabled, nil]

          field :enabled,  :toggle
          field :menus, :menu
          field :name
          field :fullpath do
            pretty_value do
              bindings[:view].content_tag(:a, bindings[:object].fullpath, href: bindings[:object].fullpath)
            end
          end
          field :redirect
          field :slug
          Enjoy.apply_patches self
        end
        edit do
          field :name
          field :excerpt, :ck_editor
          field :content, :ck_editor
          Enjoy.apply_patches self
          group :menu do
            label I18n.t('rs.menu')
            field :menus
            field :fullpath, :string do
              help I18n.t('rs.with_final_slash')
            end
            field :regexp, :string do
              help I18n.t('rs.page_url_regex')
            end
            field :redirect, :string do
              help I18n.t('rs.final_in_menu')
            end
            field :text_slug
          end
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
            active true
            field :seo do
              active true
            end
          end
          group :sitemap_data, &Enjoy.sitemap_data_config
        end
        Enjoy.only_patches self, [:show, :export]
        nested_set({
          max_depth: Enjoy.config.menu_max_depth,
          scopes: []
        })

        if block_given?
          yield
        end
      }
    end

    def menu_config
      Proc.new {
        # navigation_label 'CMS'

        field :enabled, :toggle
        field :text_slug
        field :name
        Enjoy.apply_patches self
        Enjoy.only_patches self, [:show, :list, :edit, :export]

        if block_given?
          yield
        end
      }
    end

    def contact_message_config
      Proc.new {
        # navigation_label I18n.t('rs.settings')
        field :c_at do
          read_only true
        end
        field :name
        field :content, :text
        field :email
        field :phone

        Enjoy.config.contacts_fields.each_pair do |fn, ft|
          next if ft.nil?
          if ft.is_a?(Array)
            field fn, ft[1].to_sym
          else
            field fn
          end
        end

        if block_given?
          yield
        end

        Enjoy.apply_patches self
        Enjoy.only_patches self, [:show, :list, :edit, :export]
      }
    end

    def news_config(fields = {})
      Proc.new {
        # navigation_label I18n.t('rs.cms')
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
        field :excerpt, :ck_editor
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

        Enjoy.apply_patches self

        list do
          Enjoy.apply_patches self
          sort_by :time
        end

        edit do
          field :content, :ck_editor
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
          Enjoy.apply_patches self
          group :seo, &Enjoy.seo_config
          group :sitemap_data, &Enjoy.sitemap_data_config
        end

        Enjoy.only_patches self, [:show, :list, :export]

        if block_given?
          yield(self)
        end
      }
    end

    def sitemap_data_config(is_active = false)
      Proc.new {
        active is_active
        label I18n.t('rs.sitemap_data')
        field :sitemap_show
        field :sitemap_lastmod
        field :sitemap_changefreq, :enum do
          enum do
            SitemapData::SITEMAP_CHANGEFREQ_ARRAY
          end
        end
        field :sitemap_priority

        if block_given?
          yield
        end
      }
    end



    def embedded_element_config(_navigation_label = I18n.t('rs.cms'), fields = {})
      Proc.new {
        # navigation_label(_navigation_label) unless _navigation_label.nil?
        field :enabled, :toggle
        field :name, :string
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

        if block_given?
          yield
        end
      }
    end

    def embedded_image_config(fields = {})
      jcrop_proc = Proc.new do
        jcrop_options :image_jcrop_options
      end

      if block_given?
        Enjoy.embedded_element_config(
          nil,
          {image: [:jcrop, jcrop_proc]}.merge(fields),
          yield
        )
      else
        Enjoy.embedded_element_config(
          nil,
          {image: [:jcrop, jcrop_proc]}.merge(fields)
        )
      end
    end

    def gallery_config
      Proc.new {
        # navigation_label I18n.t('rs.gallery')
        field :enabled, :toggle

        field :name, :string
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

        field :image, :jcrop do
          jcrop_options :image_jcrop_options
        end

        if block_given?
          yield
        end
      }
    end

    def image_config(without_gallery = false, fields = {})
      Proc.new {
        # navigation_label I18n.t('rs.gallery')
        field :enabled, :toggle
        unless without_gallery
          field :gallery
        end
        field :name, :string
        field :image, :jcrop do
          jcrop_options :image_jcrop_options
        end
        fields.each_pair do |name, type|
          if type.nil?
            field name
          else
            field name, type
          end
        end

        if block_given?
          yield
        end
      }
    end
  end
end
