class UserFiltersController < ApplicationController

  def update

    @user_filter = current_user.user_filter



    params[:user_filter].each do |k, v|
      if v.blank? || v == -1
        @user_filter[k] = nil
        params[:user_filter].delete(k)
      end
    end

    if @user_filter.save && @user_filter.update_attributes(params[:user_filter])
      redirect_to profiles_url
    else
      flash[:errors] = "Could not save user filters"
      redirect_to profiles_url
    end
  end
end
