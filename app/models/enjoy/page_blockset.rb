module Enjoy
  if Enjoy.mongoid?
    class PageBlockset
      include Enjoy::Models::PageBlockset

      include Enjoy::Decorators::PageBlockset
    end
  end
end
