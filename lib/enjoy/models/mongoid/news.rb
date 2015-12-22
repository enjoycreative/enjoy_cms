module Enjoy
  module Models
    module Mongoid
      module News
        extend ActiveSupport::Concern
        unless Enjoy.config.news_image_styles.nil?
          include ::Mongoid::Paperclip
        end
        included do

          field :time, type: Time
          index({enabled: 1, time: 1})
          unless Enjoy.config.news_image_styles.nil?
            has_mongoid_attached_file :image, styles: Enjoy.config.news_image_styles

            def image_file_name=(val)
              return self[:image_file_name] = ""  if val == ""
              return self[:image_file_name] = nil if val == nil
              val = val.to_s
              extension = File.extname(val)[1..-1]
              file_name = val[0..val.size-extension.size-1]
              self[:image_file_name] = "#{file_name.filename_to_slug}.#{extension.filename_to_slug}"
            end
          end

          field :excerpt, type: String, localize: Enjoy.configuration.localize, default: ""
          field :content, type: String, localize: Enjoy.configuration.localize, default: ""

          scope :after_now, -> { where(:time.lt => Time.now) }
          scope :by_date, -> { desc(:time) }
        end
      end
    end
  end
end
