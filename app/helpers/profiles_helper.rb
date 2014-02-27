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

  def display_rating_status(user_id)

    "Yay, you guys all like each other!".html_safe

    "You have rated this user. Lets hope they like you!".html_safe
  end

end
