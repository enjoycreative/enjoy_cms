module Enjoy
  class ContactsController < ApplicationController
    include Enjoy::Controllers::Contacts

    include Enjoy::Decorators::Contacts
  end
end
