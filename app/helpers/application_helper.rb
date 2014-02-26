module ApplicationHelper

  def auth_token_input
    "<input
      type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\">".html_safe
  end

  def print_date(date)

  end

  def print_percentages(percentages)
    "<span class=\"match\">#{percentages[:match_percent]}% match</span>, <span class=\"friend\">#{percentages[:friend_percent]}% friends</span>".html_safe
  end

end
