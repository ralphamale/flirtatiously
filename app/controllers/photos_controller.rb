class PhotosController < ApplicationController

  def new
    @photos = current_user.profile.photos
    @profile = current_user.profile
  end


  def create
    ext = params[:photo_data][11..14][/jpeg|jpg|png/]
    file = Tempfile.new(["pic", ".#{ext}"])

    raw_data = params[:photo_data]["data:image/#{ext};base64,".length..-1]
    file.binmode
    file.write(Base64.decode64(raw_data))

    @photo = Photo.new(file: file)
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
