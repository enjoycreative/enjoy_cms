module Enjoy
  module Models
    module PageBlock
      extend ActiveSupport::Concern

      include Enjoy.orm_specific('PageBlock')

      included do
        validates :file_path, format: {
          # with: /\A(?!layouts\/).*\Z/,
          without: /\Alayouts\/.*\Z/,
          message: "Недопустимый путь к файлу"
        }

        attr_accessor :file_pathname
        after_initialize do
          self.file_pathname = Pathname.new(file_path) unless file_path.nil?
        end
      end
    end
  end
end
