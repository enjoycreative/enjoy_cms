module Enjoy
  module Admin
    module EmbeddedGalleryImage
      def self.config(fields = {})
        jcrop_proc = Proc.new do
          jcrop_options :image_jcrop_options
        end

        fields.reverse_merge!({image: [:jcrop, jcrop_proc]})
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
