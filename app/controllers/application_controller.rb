class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :find_response, :is_unacceptable?

  private

  def find_response(question_id, responses)
    responses.find { |response| response.question_id == question_id }
  end

  def is_unacceptable?(response, acceptable_responses)
    acceptable_responses.none? { |acceptable_resp| acceptable_resp.answer_id == response.answer_id}
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def log_out(user)
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end

  def require_logged_in!
    redirect_to new_session_url unless logged_in?
  end

  def require_current_user!
    redirect_to new_session_url unless logged_in?
  end

  def require_not_current_users_page!

    if params[:controller] == "messages" && params[:user_id].to_i == current_user.id
      flash[:errors] = "Cant message yourself"
      redirect_to profiles_url
    elsif params[:controller] == "profiles" && params[:id].to_i == current_user.profile.id
      redirect_to edit_profile_url(params[:id])
    end


  end

  def require_no_current_user!
    redirect_to user_url(current_user) if logged_in?
  end

end
