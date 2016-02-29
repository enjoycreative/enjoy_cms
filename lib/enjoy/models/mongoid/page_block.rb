module Enjoy
  module Models
    module Mongoid
      module PageBlock
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          field :file_path, type: String, localize: Enjoy.config.localize, default: ""
          field :partial, type: Boolean, default: true
          embedded_in :blockset, inverse_of: :blocks, class_name: "Enjoy::PageBlockset"

          enjoy_cms_html_field :content, type: String, localize: Enjoy.config.localize, default: ""
        end

        def file_pathname_as_partial
          self.file_pathname.dirname.join("_#{self.file_pathname.basename}")
        end

        def file_pathname_for_fs
          self.partial ? self.file_path_as_partial : self.file_pathname
        end

        def render_or_content_html(view, opts = {})
          unless self.file_path.blank?
            opts.merge!(partial: self.file_path)
            view.render(opts) rescue self.content_html.html_safe
          else
            self.content_html.html_safe
          end
        end

        def render_or_content(view, opts = {})
          unless self.file_path.blank?
            opts.merge!(partial: self.file_path)
            view.render(opts) rescue self.content
          else
            self.content
          end
        end

        def file_fullpath(with_ext = false, ext = ".html.slim")
          ret = nil
          unless self.file_path.blank?
            res_filename = self.file_pathname_for_fs.to_s
            res_filename += ext if with_ext
            ret = Rails.root.join("views", res_filename)
          end
          return ret
        end

      end
    end
  end
end
