module RocketCms
  if RocketCms.active_record?
    class Seo < ActiveRecord::Base
    end
  end

  class Seo
    include RocketCms::Models::Seo
    RocketCms.apply_patches self
    rails_admin &RocketCms.seo_config
    belongs_to :seoable, polymorphic: true

    def self.separate_table?
      (RocketCms.mongoid? && RocketCms.config.separate_seo_table) || (RocketCms.active_record? && Seo.table_exists?)
    end
  end
end
