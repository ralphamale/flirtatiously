class SessionsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_current_user!, :only => [:destroy]

  def new
  end

  def create
    if params[:user]

      user = if params[:user][:username] == "demo"
                set_up_demo
              else
                User.find_by_credentials(params[:user][:username], params[:user][:password])
              end

      if user
        log_in(user)
        redirect_to status_messages_url
      else
        flash[:errors] = "Could not log you in"
        render :new
      end
    else #fb auth
      auth = request.env['omniauth.auth']
      user = User.find_by_uid(auth[:uid])

      if user
        log_in(user)
        redirect_to status_messages_url
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
          redirect_to profiles_url
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

  private

  def set_up_interactions(demo_user)
    user_ids = User.pluck(:id)

    messages = ["Hey!", "Are you new to this site?", "What are you up to this weekend?", "Let's go and grab a bite."]

    user_ids[0..3].each_with_index do |u_id, i|
      message = Message.new(body: messages[i])

      mh = message.message_headers.new([{user_id: u_id,
                                        other_id: demo_user.id,
                                        is_sent: true,
                                        is_read: true},
                                        {user_id: demo_user.id,
                                        other_id: u_id,
                                        is_sent: false,
                                        is_read: false}])

      @notification = Notification.create!({
          is_read: false,
          receiver_id: demo_user.id,
          trigger_id: u_id,
          status_type: 1
      })

      message.save!
    end

    user_ids[4..7].each do |u_id|
      Rating.create!(rater_id: u_id, ratee_id: demo_user.id, likes: true)
    end
  end

  def set_up_demo
    User.find_by_username("demo").try(:destroy)

    demo_user = User.new(username: "demo", password: "password")
    demo_user.build_user_filter
    demo_user.build_profile(zip_code: 10003, birthday: "1989-06-06")
    demo_user.save!

    set_up_interactions(demo_user)

    demo_user
  end

end
