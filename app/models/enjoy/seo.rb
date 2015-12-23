module Enjoy
  if Enjoy.active_record?
    class Seo < ActiveRecord::Base
    end
  end

  class Seo
    include Enjoy::Models::Seo
    Enjoy.apply_patches self
    rails_admin &Enjoy.seo_config
    belongs_to :seoable, polymorphic: true
  end
end
