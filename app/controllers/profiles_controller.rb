class ProfilesController < ApplicationController
  before_filter :require_logged_in!
  before_filter :require_not_current_users_page!, only: [:show]
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
    @user_filter = current_user.user_filter
    @profiles = Profile.apply_filters

  end

  def show
    @profile = Profile.find(params[:id])
    other_user_id = @profile.user.id

    @current_user_responses = Question.get_responses(current_user.id)

    @current_user_acceptables = Question.get_acceptable_responses(current_user.id)

    @other_user_responses = Question.get_responses(other_user_id)

    @other_user_acceptables = Question.get_acceptable_responses(other_user_id)

    @match_info = current_user.calculate_percentages(@profile.user)

    # @other_user_acceptable_responses = get_acceptable_responses(@profile.user.id)
#     @responses = get_responses(@profile.user.id)

   # fail

  end

  def destroy

  end

  private

  # def get_acceptable_responses(other_user_id)
  #   User.find(other_user_id).acceptable_responses
  # end
  #
  # def is_unacceptable?(response, acceptable_responses)
  #
  #
  # end
  #
  # def get_responses(other_user_id)
  #
  #   responses = Response.find_by_sql ["
  #
  #     SELECT questions.id AS question_id,
  #     questions.text AS question_text,
  #     other_user_answer_choices.text AS other_user_answer_text,
  #     other_user_answer_choices.id AS other_user_answer_id,
  #     current_user_responses.answer_choice_id AS current_user_answer_id,
  #     current_user_responses.answer_choice_text AS current_user_answer_text
  #
  #     FROM questions
  #     INNER JOIN responses
  #     AS other_user_responses
  #     ON other_user_responses.question_id = questions.id
  #
  #     INNER JOIN answer_choices
  #     AS other_user_answer_choices
  #     ON other_user_responses.answer_choice_id = other_user_answer_choices.id
  #
  #     LEFT OUTER JOIN
  #     (SELECT responses.question_id AS question_id, answer_choices.id AS answer_choice_id, answer_choices.text AS answer_choice_text
  #     FROM responses
  #     JOIN answer_choices
  #     ON responses.answer_choice_id = answer_choices.id
  #     WHERE responses.user_id = ?)
  #     AS current_user_responses ON
  #     other_user_responses.question_id = current_user_responses.question_id
  #     WHERE other_user_responses.user_id = ?", current_user.id, other_user_id]
  #
  #
  #     return parse_responses(responses, other_user_id)
  # end
  #
  # def parse_responses(responses, other_user_id)
  #   results = [];
  #   current_user_acceptable_responses = current_user.acceptable_responses
  #   other_user_acceptable_responses = User.find(other_user_id).acceptable_responses
  #
  #   responses.each do |response|
  #     resultObj = {}
  #     resultObj[:question_id] = response.question_id
  #     resultObj[:question_text] = response.question_text
  #     resultObj[:other_user_answer_text] = response.other_user_answer_text
  #     resultObj[:other_user_answer_id] = response.other_user_answer_id
  #     resultObj[:current_user_answer_text] = response.current_user_answer_text
  #     resultObj[:current_user_answer_id] = response.current_user_answer_id
  #
  #     resultObj[:acceptable_to_current_user] = is_acceptable?(response, "C", current_user_acceptable_responses)
  #     resultObj[:importance_to_current_user] = find_importance(response.question_id, current_user_acceptable_responses)
  #     resultObj[:acceptable_to_other_user] = is_acceptable?(response, "O", other_user_acceptable_responses)
  #     resultObj[:importance_to_other_user] = find_importance(response.question_id, other_user_acceptable_responses)
  #     results.push(resultObj)
  #   end
  #
  #   return results
  #
  # end
  #
  # def find_importance(question_id, acceptable_responses)
  #   return acceptable_responses.find { |ar| ar.question_id == question_id}.importance
  # end
  #
  #
  # def is_acceptable?(response, user_type, acceptable_responses)
  #   acceptable_for_question = acceptable_responses.select { |ar| ar.question_id == response.question_id}
  #   acceptable_answer_choices = acceptable_for_question.collect(&:answer_choice_id)
  #
  #   #WHY THE FUCK DO I NEED TO_I???
  #
  #   if user_type == "C"
  #    # fail if response.question_id == 4
  #     return acceptable_answer_choices.include?(response.other_user_answer_id.to_i)
  #
  #   else #user is O
  #    # fail if response.question_id == 4
  #     return acceptable_answer_choices.include?(response.current_user_answer_id.to_i)
  #   end
  #
  #
  #
  # end

end
