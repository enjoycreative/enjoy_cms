module RocketCms
  if RocketCms.mongoid?
    class EmbeddedGalleryImage < EmbeddedElement
      include RocketCms::Models::EmbeddedGalleryImage
      RocketCms.apply_patches self

      # use it in inherited model
      #rails_admin &RocketCms.embedded_image_config

      # use it in rails_admin in parent model for sort
      # sort_embedded({fields: [:embedded_field_1, :embedded_field_2...]})
      # or u need to override rails_admin in inherited model to add sort field
    end
  end
end
