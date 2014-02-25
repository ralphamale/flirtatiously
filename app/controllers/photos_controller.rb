class PhotosController < ApplicationController

  def new

  end


  def create
  @photo = Photo.new(params[:photo])
  @photo.profile_id = current_user.profile.id

  if @photo.save
    render json: @photo
  else
    render json: @photo.errors.full_messages, status: 422
  end

  end

  def destroy

  end

end
