module Enjoy::Seoable
  extend ActiveSupport::Concern
  LOCALIZED_FIELDS = [:h1, :title, :keywords, :description, :og_title]
  FIELDS = LOCALIZED_FIELDS + [:og_image, :robots]

  included do
    has_one :seo, as: :seoable, autosave: true, class_name: "Enjoy::Seo"
    accepts_nested_attributes_for :seo

    delegate *FIELDS, to: :seo
    delegate *(FIELDS.map {|f| "#{f}=".to_sym }), to: :seo

    if Enjoy.config.localize
      delegate *(LOCALIZED_FIELDS.map {|f| "#{f}_translations".to_sym }), to: :seo
      delegate *(LOCALIZED_FIELDS.map {|f| "#{f}_translations=".to_sym }), to: :seo
    end

    alias seo_without_build seo
    def seo
      seo_without_build || build_seo
    end
  end

  def page_title
    title.blank? ? name : title
  end

  def get_og_title
    og_title.blank? ? name : og_title
  end

  def og_image_jcrop_options
    {aspectRation: 800.0/600.0}
  end

end
