class ProfilesController < ApplicationController
  before_filter :require_logged_in!
  #before_filter :require_not_current_users_page!, only: [:show]
  #layout "show_profile", only: [:show, :edit]

  def index
    @user_filter = current_user.user_filter
    current_user_pid = current_user.profile.id
    @profiles = Profile.apply_filters(@user_filter, current_user)
      .page(params[:page])
    #render layout: "browse_profile"
  end

  def random
    @profile = Profile.get_random_unrated(current_user)
    redirect_to profile_url(@profile)
  end


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
      respond_to do |format|
        format.html { redirect_to profile_url(params[:id]) }
        format.json { render :json => @profile }
      end
    else
      respond_to do |format|
        format.html { render :json => @profile.errors.full_messages }
        format.json { render :json => @profile.errors.full_messages }
      end
    end
  end



  def show
    @profile = Profile.find(params[:id])

    show_profile_helper

   #  other_user_id = @profile.user.id
   #
   #  @is_current_user_profile = is_current_user_profile?(@profile)
   #
   #  @current_user_responses = Question.get_responses(current_user.id)
   #  @current_user_acceptables = Question.get_acceptable_responses(current_user.id)
   #  @other_user_responses = Question.get_responses(other_user_id)
   #  @other_user_acceptables = Question.get_acceptable_responses(other_user_id)
   #
   #  @match_info = current_user.calculate_percentages(@profile.user)
   #
   # @rating_status = Rating.status(current_user.id, @profile.user_id)

  end

  def destroy

  end

  private

  def show_profile_helper
    other_user_id = @profile.user.id

    @is_current_user_profile = is_current_user_profile?(@profile)

    @current_user_responses = Question.get_responses(current_user.id)
    @current_user_acceptables = Question.get_acceptable_responses(current_user.id)
    @other_user_responses = Question.get_responses(other_user_id)
    @other_user_acceptables = Question.get_acceptable_responses(other_user_id)

    @match_info = current_user.calculate_percentages(@profile.user)

   @rating_status = Rating.status(current_user.id, @profile.user_id)
  end

end
