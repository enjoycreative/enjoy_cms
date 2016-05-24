module Enjoy::PoweredHelper
  def render_enjoy_powered_block
    content_tag :div, class: 'powered' do
      ret = []
      ret << content_tag(:span, class: 'powered') do
        "Сайт разработан"
      end
      ret << link_to("Enjoy Creative studio", "http://enjoycreate.ru", class: "powered_by", target: "_blank", title: "Enjoy Creative studio")
      ret.join.html_safe
    end
  end
end
