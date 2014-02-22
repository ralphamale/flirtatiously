class RatingsController < ApplicationController

  def create
    respond_to do |format|
      format.html { redirect_to profile_url(params[:id]) }
      format.json { render :json => @profile }
    end
  end
end
