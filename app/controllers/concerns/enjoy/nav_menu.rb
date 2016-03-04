module Enjoy::NavMenu
  extend ActiveSupport::Concern
  included do
    helper_method :navigation
  end

  private
  def render_with_subs(items, primary, item)
    subs = items.select { |i| i.parent_id == item.id && !i.name.blank? && i.enabled }
    if subs.empty?
      block = nil
    else
      block = Proc.new do |sub_nav|
        subs.each { |sub|
          render_with_subs(items, sub_nav, sub)
        }
      end
    end
    # cr = item.clean_regexp
    navigation_item(primary, item, block)
  end

  def navigation_item(primary, item, block=nil)
    url = nav_get_url(item)
    if block.nil?
      primary.item(item.slug, item.name, url, item.nav_options)
    else
      primary.item(item.slug, item.name, url, item.nav_options, &block)
    end
  end

  def navigation(type)
    Proc.new do |primary|
      SimpleNavigation.config.autogenerate_item_ids = false
      begin
        nav_extra_data_before(type, primary)
        all_items = nav_get_menu_items(type)
        items = all_items.select { |i| i.parent_id.nil? && !i.name.blank? && i.enabled }
        items.each do |item|
          render_with_subs(all_items, primary, item)
        end
        nav_extra_data_after(type, primary)
      rescue Exception => exception
        Rails.logger.error exception.message
        Rails.logger.error exception.backtrace.join("\n")
        puts exception.message
        puts exception.backtrace.join("\n")
        capture_exception(exception) if respond_to?(:capture_exception)
        items || []
      end
    end
  end

  def nav_get_url(item)
    _connectable = item.connectable
    if _connectable and _connectable.enabled
      begin
        _routes_namespace = _connectable.respond_to?(:routes_namespace) ? _connectable.routes_namespace : :main_app
        send(_routes_namespace.to_sym).url_for(_connectable)
      rescue Exception => exception
        Rails.logger.error exception.message
        Rails.logger.error exception.backtrace.join("\n")
        puts exception.message
        puts exception.backtrace.join("\n")
        capture_exception(exception) if respond_to?(:capture_exception)
        
        item.redirect.blank? ? item.fullpath : item.redirect
      end
    else
      item.redirect.blank? ? item.fullpath : item.redirect
    end
  end
  def nav_get_menu_items(type)
    menu = menu_class.find(type.to_s)
    menu.pages.enabled.sorted.to_a if menu
  end
  def nav_extra_data_before(type, primary)
    # override for additional config or items
  end
  def nav_extra_data_after(type, primary)
    # override for additional config or items
  end

  def menu_class_name
    "Enjoy::Menu"
  end
  def menu_class
    menu_class_name.constantize
  end
end
