module RocketCmsMongoidPaperclip
  extend ActiveSupport::Concern

  module ClassMethods
    def rocket_cms_mongoid_attached_file(name, opts = {})
      name = name.to_sym
      unless opts.blank?
        content_type = opts.delete(:content_type)
        jcrop_options = opts.delete(:jcrop_options)
      end

      has_mongoid_attached_file name, opts
      validates_attachment name, content_type: content_type unless content_type.blank?
      class_eval <<-EVAL
        def #{name}_file_name=(val)
          return self[:#{name}_file_name] = ""  if val == ""
          return self[:#{name}_file_name] = nil if val == nil
          val = val.to_s
          extension = File.extname(val)[1..-1]
          file_name = val[0..val.size-extension.size-1]
          self[:#{name}_file_name] = "\#{file_name.filename_to_slug}.\#{extension.filename_to_slug}"
        end
      EVAL
      if jcrop_options
        class_eval <<-EVAL
          def #{name}_jcrop_options
            #{jcrop_options}
          end
        EVAL
      end
    end
  end
end

RocketCMSMongoidPaperclip = RocketCmsMongoidPaperclip
