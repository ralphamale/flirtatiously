class QuestionsController < ApplicationController
  before_filter :require_current_user!


  def index
    unanswered_questions = Question.pluck(:id) - current_user.answered_questions.pluck(:id)

    random_id = unanswered_questions.sample
    @random_question = (random_id.nil?) ? nil : Question.find(random_id)

    @answered_questions = Response.find_by_sql ["
      SELECT questions.text AS question_text, responses.id AS response_id, answer_choices.text AS answer_text, questions.id AS question_id
      FROM questions
      JOIN answer_choices
      ON questions.id = answer_choices.question_id
      JOIN responses
      ON responses.answer_choice_id = answer_choices.id

      WHERE responses.user_id = ?
      ", current_user.id]

  end

  def edit_answer
    question_id = params[:question_id]
    @answer_choices = Question.joins(:answer_choices).select("questions.id AS question_id, questions.text AS question_text, answer_choices.id AS answer_choice_id, answer_choices.text AS answer_choice_text").where("questions.id = ?", question_id)

    @response = current_user.responses.where(:question_id => question_id).first
    @acceptable_responses = current_user.acceptable_responses.where(:question_id => question_id)


  end

  def update_answer
    @question = 6;
    fail
    @answer = 5
    dick = 5
  end

  def show
    @question = Question.find(params[:id])
  end


  def answer
      begin
        ActiveRecord::Base.transaction do

          @response = current_user.responses.new(params[:response]);


          acceptable_response_attrs = params[:acceptable_response].values.each do |attrs|
            attrs[:importance] = params[:all_acceptable_response][:importance]
            attrs[:question_id] = params[:question_id]
          end

          @acceptable_responses = current_user.acceptable_responses.new(params[:acceptable_response].values)

          @response.save
          @acceptable_responses.each do |acceptable_response|
            acceptable_response.save
          end


          raise "invalid" unless @response.valid? && @acceptable_responses.all? { |obj| obj.valid? }
        end
      rescue
        # because we "soft" saved @user and @addresses we now
        # have access to all of the validation errors
        render :json => "Error solving"
      else
        redirect_to profiles_url
      end
  end

  def create

  end

end
