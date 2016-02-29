module Enjoy::Blocksetable
  extend ActiveSupport::Concern
  included do
    helper_method :render_blockset
  end

  private
  def render_blockset(view, type)
    ret = []
    begin
      blocks = blockset_get_blocks(type)
      blocks.each do |block|
        ret << block.render_or_content_html(view)
      end
    rescue Exception => exception
      Rails.logger.error exception.message
      Rails.logger.error exception.backtrace.join("\n")
      puts exception.message
      puts exception.backtrace.join("\n")
      capture_exception(exception) if respond_to?(:capture_exception)
      # ret << blocks || []
    end
    ret.join.html_safe
  end

  def blockset_get_blocks(type)
    blockset = blockset_class.find(type.to_s)
    blockset.blocks.enabled.sorted.to_a if blockset
  end

  def blockset_class_name
    "Enjoy::PageBlockset"
  end
  def blockset_class
    blockset_class_name.constantize
  end
end
