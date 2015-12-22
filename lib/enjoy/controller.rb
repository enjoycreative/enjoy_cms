module Enjoy::Controller
  extend ActiveSupport::Concern
  included do
    include RsErrors
    include RsPages
    include RsMenu
    include RsFancybox
    protect_from_forgery with: :exception
    helper_method :page_title
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
end
