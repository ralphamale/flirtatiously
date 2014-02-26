class QuestionsController < ApplicationController
  before_filter :require_current_user!


  def index
    @random_question = Question.get_random_unanswered(current_user)

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

  def random
    if request.xhr?
      @new_question = Question.get_random_unanswered(current_user)
      render partial: "answer_question", locals: {question: @new_question}
    end
  end

  def edit_answer
    question_id = params[:question_id]
    #includes is eagerly fetching.
    #joins(:answer_choices).includes(:answer_choices) questions.text, answer_choices.id, answer_choices.text  //

    @question = Question.joins(:answer_choices)
                        .includes(answer_choices: [:responses])
                        .where(:id => question_id)
                        .where("responses.user_id = ?", current_user.id)
                        .first

    @question.answer_choices.each do |answer_choice|
      answer_choice.responses.first #check to see if exist.

    end

    @answer_choices = Question.joins(:answer_choices).select("questions.id AS question_id, questions.text AS question_text, answer_choices.id AS answer_choice_id, answer_choices.text AS answer_choice_text").where("questions.id = ?", question_id)
    #each answer choice has many responses.
    #includes responses with answer choices
    #responses.where(:user_id => current_user.id)

    @response = current_user.responses.where(:question_id => question_id).first
    @acceptable_responses = current_user.acceptable_responses.where(:question_id => question_id)


  end

  def update_answer
    question_id = params[:question_id]
    responses = current_user.responses.where(question_id: question_id)
    @response = responses.first


    begin
      @response.transaction do
        # if responses.length is 0, raise error. otherwise, take first.
        @response.update_attributes(params[:response])

        prev_acceptables = current_user.acceptable_responses.where(question_id: question_id)

        new_importance = params[:all_acceptable_response][:importance] #will need to do to_i.
        new_acceptable_ans_ids = params[:acceptable_response][:answer_choice_ids].map(&:to_i)

        new_answer_choice_ids_to_add = new_acceptable_ans_ids.select { |ar_id| prev_acceptables.none? {|prev_ar| prev_ar.answer_choice_id == ar_id}} #bang select

        ar_ids_to_delete = prev_acceptables.select{ |ar| new_acceptable_ans_ids.none? {|ans_id| ar.answer_choice_id == ans_id}}.map(&:id) #bang select

        new_answer_choice_ids_to_add.each do |answer_choice_id|
          AcceptableResponse.create({user_id: current_user.id, answer_choice_id: answer_choice_id, importance: new_importance, question_id: question_id})
        end

        AcceptableResponse.destroy_all(:id => ar_ids_to_delete)
        prev_acceptables.delete_if { |ar| ar_ids_to_delete.include?(ar.id)}

        prev_acceptables.each do |ar|
          ar.update_attributes(importance: new_importance)
        end
      end
      if request.xhr?
        render partial: "update_confirmation", locals: {question_text: Question.find(question_id).text, answer_text: AnswerChoice.find(params[:response][:answer_choice_id]).text}
      else
        render json: "WTF"
      end
    rescue ActiveRecord::RecordInvalid => invalid
      debugger
      flash[:errors] = "Could not update response."
      render json: "ERROR COULD NOT UPDATE"
      #redirect_to profiles_url
    end

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
        flash[:errors] = "Error answering the question"
        redirect_to profiles_url
      else
        if request.xhr?
          @new_question = Question.get_random_unanswered(current_user)
          if @new_question
            render partial: "answer_question", locals: {question: @new_question}
          else
            render text: "No more questions."
          end
        else
          redirect_to questions_url
        end

      end
  end

  def create

  end

end
