class ProfilesController < ApplicationController
  before_filter :require_logged_in!

  def new

  end

  def create
    @user = current_user

    @user.build_profile(params[:profile])

    if @user.save
      redirect_to profile_url(@user.profile)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update_attributes(params[:profile])
      redirect_to profile_url(params[:id])
    else
      render :json => @profile.errors.full_messages
    end
  end

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])

    @responses = get_responses(@profile.user.id)

  end

  def destroy

  end

  private

  def get_responses(other_user_id)
    return Response.find_by_sql ["

    SELECT questions.id AS question_id,
    questions.text AS question_text,
    other_user_answer_choices.text AS other_user_answer_text,
    other_user_answer_choices.id AS other_user_answer_id,
    current_user_answer_choices.text AS current_user_answer_text,
    current_user_answer_choices.id AS current_user_answer_id

    FROM questions
    INNER JOIN responses
    AS other_user_responses
    ON other_user_responses.question_id = questions.id

    INNER JOIN answer_choices
    AS other_user_answer_choices
    ON other_user_responses.answer_choice_id = other_user_answer_choices.id

    LEFT OUTER JOIN responses
    AS current_user_responses
    ON other_user_responses.question_id = current_user_responses.question_id

    INNER JOIN answer_choices
    AS current_user_answer_choices
    ON current_user_responses.answer_choice_id = current_user_answer_choices.id

    WHERE other_user_responses.user_id = ? AND current_user_responses.user_id = ?


                  ", other_user_id, current_user.id]




  end

end
