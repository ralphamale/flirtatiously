class RatingsController < ApplicationController

  def create
    @rating = Rating.new(params[:rating])
    @rating.rater_id = current_user.id

    ratee_id = params[:rating][:ratee_id].to_i

    @reciprocal_rating = Rating.where(:rater_id => ratee_id).where(:ratee_id => current_user.id).first

    unless @reciprocal_rating.blank?
      mutual_like = @reciprocal_rating.likes && @rating.likes

      @reciprocal_rating.is_mutual, @rating.is_mutual = [mutual_like]*2
      @reciprocal_rating.save!

      if (mutual_like)
        #notify the other user!
        Notification.create({
          is_read: false,
          receiver_id: ratee_id,
          trigger_id: current_user.id,
          status_type: 0
          })
      end
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
