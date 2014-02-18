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
    "<font class=\"match\">#{percentages[:match_percent]}% match</font>, <font class=\"friend\">#{percentages[:friend_percent]}% friends</font>".html_safe
  end

end
