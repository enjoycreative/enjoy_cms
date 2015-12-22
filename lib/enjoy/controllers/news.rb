module Enjoy
  module Controllers
    module News
      extend ActiveSupport::Concern

      def index
        @news = model.enabled.after_now.by_date

        unless Enjoy.config.news_per_page.nil?
          @news = @news.page(params[:page])
        end
      end

      def show
        @news = model.after_now.find(params[:id])

        if @news and @news.text_slug != params[:id]
          redirect_to @news, status_code: 301
          return true
        end
      end

      private
      def model
        Enjoy::News
      end
      def page_title
        if @news.class.name == model.name
          @news.page_title
        else
          super
        end
      end
    end
  end
end
