class UsersController < ApplicationController
  before_filter :require_current_user!, :except => [:create, :new]
  before_filter :require_no_current_user!, :only => [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    begin
      @user.transaction do
        @user.build_user_filter
        @user.build_profile(params[:profile])
        @user.save
      end

      log_in(@user)
      redirect_to profile_url(@user.profile)
    rescue ActiveRecord::RecordInvalid => invalid
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def update
    @user = current_user
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update_attributes(params[:user])
      if request.xhr?
        render json: @user
      else
        render json: @user.errors
      end
    else
      if request.xhr?
        render json: @user.errors
      else

      end
    end

  end

  def destroy

  end

  def like
    @like_back = Like.find_by_likee_id_and_liker_id(params[:id], current_user.id)

    @like = Like.create(liker_id: current_user.id, likee_id: params[:id], is_mutual: false)
    if @like_back
      @like_back.is_mutual = true
      @like.is_mutual = true
    end

    begin
      @like.transaction do
        @like.save!
        @like_back.save! if @like_back
      end
      redirect_to profile_url(params[:id])
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:errors] = "Like not saved."
      redirect_to :back
    end
  end

end
