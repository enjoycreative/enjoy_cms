module RocketCms
  if RocketCms.mongoid?
    class GalleryImage
      include RocketCms::Models::GalleryImage
      RocketCms.apply_patches self

      rails_admin &RocketCms.image_config
    end
  end
end
