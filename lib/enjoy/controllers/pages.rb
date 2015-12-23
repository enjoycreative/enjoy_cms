module Enjoy
  module Controllers
    module Pages
      extend ActiveSupport::Concern
      def show
        if @seo_page.nil? || !@seo_page.persisted?
          if !params[:id].blank? or !params[:slug].blank?
            @seo_page = model.enabled.find(params[:id] || params[:slug])
          end
        end
        if @seo_page.nil?
          render_404
          return true
        end
      end

      def model
        Enjoy::Page
      end
    end
  end
end
