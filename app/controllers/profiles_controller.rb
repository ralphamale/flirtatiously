class ProfilesController < ApplicationController
  before_filter :require_logged_in!

  def new

  end

  def create
    @user = current_user
    
    @user.build_profile(params[:profile])

    if @user.save
      redirect_to profile_url(@user.profile)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def edit

  end

  def update

  end

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def destroy

  end

end
