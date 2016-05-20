module Enjoy::Controller
  extend ActiveSupport::Concern
  included do
    include Enjoy::Errors
    include Enjoy::Fancybox
    if defined?(Enjoy::Pages)
      include Enjoy::Pages::SeoPages
      include Enjoy::Pages::NavMenu
      include Enjoy::Pages::Blocksetable
    end
    protect_from_forgery with: :exception
    helper_method :page_title
    helper_method :hide_ym_ga
  end

  protected

  def page_title
    if @seo_page.nil?
      Settings ? Settings.default_title : "" #temp
    else
      @seo_page.page_title
    end
  end

  def ckeditor_authenticate
    redirect_to '/' unless user_signed_in? && current_user.has_role?('admin')
  end


  def hide_ym_ga
    false
  end
end
