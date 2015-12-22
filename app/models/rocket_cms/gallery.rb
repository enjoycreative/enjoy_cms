module RocketCms
  if RocketCms.mongoid?
    class Gallery
      include RocketCms::Models::Gallery
      RocketCms.apply_patches self

      rails_admin &RocketCms.gallery_config
    end
  end
end
