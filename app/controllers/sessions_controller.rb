class SessionsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_current_user!, :only => [:destroy]

  def new
  end

  def create
    if params[:user]

    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

      if user
        log_in(user)
        redirect_to profiles_url
      else
        flash[:errors] = "Could not log you in"
        render :new
      end
    else #fb auth
      auth = request.env['omniauth.auth']
      user = User.find_by_uid(auth[:uid])

      if user
        log_in(user)
        redirect_to edit_profile_url(user.profile)
      end

      unless user
        user = User.create!(
          uid: auth[:uid], username: auth["extra"]["raw_info"]["first_name"]
        )

    #     zip_code
    # t.date     "birthday",               :null => false

        begin
          user.transaction do
            user.build_user_filter
            user.build_profile({zip_code: 10003, birthday: auth["extra"]["raw_info"]["birthday"]})
            user.save
          end
          log_in(user)
          redirect_to edit_profile_url(user.profile)
        rescue ActiveRecord::RecordInvalid => invalid
          flash.now[:errors] = @user.errors.full_messages
          render :new
        end




      end

      #log_in(user) after.
      # all separarted bycommas as in jonathans example.
      # , first_name: auth[:info][:first_name],
      # last_name: auth[:info][:last_name],
      # email: auth[:info][:email],
      # image: auth[:info][:image]

    end
  end

  def destroy

    log_out(current_user)
    redirect_to new_session_url
  end

end
