module Enjoy::PoweredHelper
  def render_enjoy_powered_block
    content_tag :div, class: 'enjoy-powered' do
      ret = []
      ret << content_tag(:span, class: 'powered') do
        "Сайт разработан"
      end
      _attrs = {
        class: "powered_by",
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
