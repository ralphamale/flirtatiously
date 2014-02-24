class RatingsController < ApplicationController

  def create
    @rating = Rating.new(params[:rating])
    @rating.rater_id = current_user.id

    ratee_id = params[:rating][:ratee_id].to_i

    @reciprocal_rating = Rating.where(:rater_id => ratee_id).where(:ratee_id => current_user.id).first

    unless @reciprocal_rating.blank?
      @reciprocal_rating.is_mutual, @rating.is_mutual =
        ((@reciprocal_rating.likes && @rating.likes) ? [true] : [false]) * 2
        # on true, let's also notify both users!
      @reciprocal_rating.save!
    end

    @rating.save!

    render :json => @rating, :status => :ok

    end

      #ismutual should only be marked when both parties do each otehr.
      #else leave ismutual to be nil.

      #if one is found
      #if reciprocal_rating = @rating.likes

      #if one is not found.

    if @reciprocal_rating.nil? || reciprocal_rating.likes



# :is_mutual, :likes, :ratee_id, :rater_id
#check for mutuality.
    respond_to do |format|
      format.html { redirect_to profile_url(params[:id]) }
      format.json { render :json => @profile }
    end
  end
end
