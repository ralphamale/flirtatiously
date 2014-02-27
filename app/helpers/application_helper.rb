module ApplicationHelper

  def auth_token_input
    "<input
      type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\">".html_safe
  end

  def display_photo(profile, type)

    url = if profile && profile.photos.exists?
            profile.photos.first.file.url(:avatar)
          else
            asset_path "img_placeholder.png"
          end



    #everytime use, need to put in enclosing div.
    "<img src=\"#{url}\" height=\"100%\" width=\"100%\">".html_safe


  end


  def print_date(date)

  end

  def print_percentages(percentages)
    "<span class=\"match\">#{percentages[:match_percent]}% match</span>, <span class=\"friend\">#{percentages[:friend_percent]}% friends</span>".html_safe
  end

end
