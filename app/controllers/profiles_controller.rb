class ProfilesController < ApplicationController
  before_filter :require_logged_in!
  before_filter :require_not_current_users_page!, only: [:show]
  layout "browse_profile", only: [:index]
  layout "show_profile", only: [:show, :edit]
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
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update_attributes(params[:profile])
      redirect_to profile_url(params[:id])
    else
      render :json => @profile.errors.full_messages
    end
  end

  def index
    @user_filter = current_user.user_filter
    @profiles = Profile.apply_filters

  end

  def show
    @profile = Profile.find(params[:id])
    other_user_id = @profile.user.id

    @current_user_responses = Question.get_responses(current_user.id)
    @current_user_acceptables = Question.get_acceptable_responses(current_user.id)
    @other_user_responses = Question.get_responses(other_user_id)
    @other_user_acceptables = Question.get_acceptable_responses(other_user_id)

    @match_info = current_user.calculate_percentages(@profile.user)
  end

  def destroy

  end

end
