module ApplicationHelper
  def sidebar_item(text, link)
    if current_page?(link)
      result = '<li class="active">'
    else
      result = '<li>'
    end
    result += link_to(text, link)
    result += '</li>'
    result.html_safe
  end
end
