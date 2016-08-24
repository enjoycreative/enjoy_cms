module Enjoy::PoweredHelper

  # TODO CMS site block
  # def render_enjoy_powered_by_block
  #   content_tag :div, class: 'enjoy-powered' do
  #     ret = []
  #     ret << content_tag(:span, class: 'powered') do
  #       "Сайт работает на "
  #     end
  #     _attrs = {
  #       class: "powered_by",
  #       target: "_blank",
  #       title: "Enjoy CMS",
  #       data: {
  #         "enjoy-goto-disabled": true
  #       }
  #     }
  #     ret << link_to("Enjoy CMS", "http://cms.enjoycreate.ru", _attrs)
  #     ret.join.html_safe
  #   end
  # end

  def render_enjoy_created_by_block
    content_tag :div, class: 'enjoy-created-by' do
      ret = []
      ret << content_tag(:span, class: 'created-by') do
        "Сайт разработан"
      end
      _attrs = {
        class: "created_by",
        target: "_blank",
        title: "Enjoy Creative studio",
        data: {
          "enjoy-goto-disabled": true
        }
      }
      ret << link_to("Enjoy Creative studio", "http://enjoycreate.ru", _attrs)
      ret.join.html_safe
    end
  end

end
