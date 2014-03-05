module ProfilesHelper

  def display_detail(value, detail, current_profile)
    return value if value

    if current_profile
      if detail == "Essay"
        "<span class='profile-placeholder'>Write something here!</span>".html_safe
      else
        "<span class='profile-placeholder'>Choose Your #{detail}</span>".html_safe
      end
    else
      "-"
    end
  end

end
