class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.build_profile

    if @user.save
      log_in(@user)
      redirect_to profiles_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  #####

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
      flash.now[:errors] = "Like not saved."
      redirect_to :back
    end
  end

  #####


end
