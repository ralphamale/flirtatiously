class UserFiltersController < ApplicationController

  def update
    @user_filter = current_user.user_filter

    if @user_filter.update_attributes(params[:user_filter])
      redirect_to profiles_url
    else
      flash[:errors] = "Could not save user filters"
      redirect_to profiles_url
    end
  end
end
