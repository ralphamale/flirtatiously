class SessionsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_current_user!, :only => [:destroy]

  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      log_in(user)
      redirect_to profiles_url
    else
      render :new
    end
  end

  def destroy
    fail
    log_out(current_user)
    redirect_to new_session_url
  end

end
