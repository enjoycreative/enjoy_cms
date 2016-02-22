module Enjoy
  if Enjoy.mongoid?
    class PageBlock < Enjoy::EmbeddedElement
      include Enjoy::Models::PageBlock

      include Enjoy::Decorators::PageBlock
    end
  end
end
