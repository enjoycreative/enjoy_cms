module Enjoy
  module Admin
    module EmbeddedGalleryImage
      def self.config(fields = {})
        jcrop_proc = Proc.new do
          jcrop_options :image_jcrop_options
        end

        if fields
          if fields.is_a?(Hash)
            fields.reverse_merge!({image: [:jcrop, jcrop_proc]})
          else
            finded = false
            fields.each { |g|
              finded = !!g[:fields][:image] unless finded
            }
            unless finded
              fields << {
                name: :image,
                fields: {
                  image: [:jcrop, jcrop_proc]
                }
              }
            end
          end
        end
        
        if block_given?
          Enjoy::Admin::EmbeddedElement.config(nil, fields) do |config|
            yield config
          end
        else
          Enjoy::Admin::EmbeddedElement.config(nil, fields)
        end
      end
    end
  end
end
