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

  end

  def update

  end

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    # works for 
    # @responses = Response.find_by_sql ["
    #               
    #               SELECT other_answer_choices.text AS other_answer, cur_user_answer_choices.text AS cur_user_answer, questions.text AS question_text, questions.id AS question_id
    #               FROM questions JOIN 
    #               (SELECT * FROM responses WHERE responses.user_id= ?) AS other_responses 
    #               ON questions.id = other_responses.question_id
    #               JOIN answer_choices AS other_answer_choices ON other_answer_choices.question_id = questions.id
    #               LEFT OUTER JOIN
    #               (SELECT * FROM responses WHERE responses.user_id = ?) AS cur_user_responses
    #               ON other_responses.question_id = cur_user_responses.question_id
    #               LEFT OUTER JOIN answer_choices AS cur_user_answer_choices
    #               ON cur_user_responses.answer_choice_id = cur_user_answer_choices.id
    #               WHERE other_responses.answer_choice_id = other_answer_choices.id
    #               
    #               
    #               
    #               ", params[:id], current_user.id]
    
    
    #acceptable :answer_choice_id, :importance, :user_id, :question_id, :answer_choice_ids
    # response attr_accessible :answer_choice_id, :user_id, :question_id
    @responses = Response.find_by_sql ["
      
      SELECT questions.text AS question_text, questions.id AS question_id, other_answer_choices.text AS other_answer, cur_user_answer_choices.text AS cur_user_answer, 
      (CASE WHEN cur_user_acceptable_responses.answer_choice_id IS NULL THEN 0 ELSE 1 END) AS acceptable_to_current_user, 
      (CASE WHEN other_acceptable_responses.answer_choice_id IS NULL THEN 0 ELSE 1 END) AS acceptable_to_other
      FROM questions JOIN 
      (SELECT * FROM responses WHERE responses.user_id= ?) AS other_responses 
      ON questions.id = other_responses.question_id
      
      LEFT OUTER JOIN (SELECT * FROM acceptable_responses WHERE acceptable_responses.user_id = ?)
      AS cur_user_acceptable_responses
      ON other_responses.answer_choice_id = cur_user_acceptable_responses.answer_choice_id
      
      JOIN answer_choices AS other_answer_choices ON other_answer_choices.question_id = questions.id
      LEFT OUTER JOIN
      (SELECT * FROM responses WHERE responses.user_id = ?) AS cur_user_responses
      ON other_responses.question_id = cur_user_responses.question_id
      
      LEFT OUTER JOIN (SELECT * FROM acceptable_responses WHERE acceptable_responses.user_id = ?)
      AS other_acceptable_responses
      ON cur_user_responses.answer_choice_id = other_acceptable_responses.answer_choice_id
      
      LEFT OUTER JOIN answer_choices AS cur_user_answer_choices
      ON cur_user_responses.answer_choice_id = cur_user_answer_choices.id
      WHERE other_responses.answer_choice_id = other_answer_choices.id", params[:id], current_user.id, current_user.id, params[:id]] 
    
    
  end

  def destroy

  end

end
