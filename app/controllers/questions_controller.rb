class QuestionsController < ApplicationController

  def index
    # @random_unanswered_question =

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
    @question = Question.find(params[:question_id])

    @response = current_user.responses.find { |response| response.question_id == params[:question_id].to_i}

    @acceptable_response

  end

  def update_answer

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
        flash[:errors] = @user.errors + @addresses.map(&:errors).flatten
        render :new
      else
        redirect_to profiles_url
      end



    ##########
    # @acceptable_responses = AcceptableResponse.create(params[:acceptable_response])

    # @acceptable_responses = AcceptableResponse.create(params[:acceptable_response].values.delete_if { |acceptable_response_value| acceptable_response_value[:answer_choice_id].nil? })
    #
    # @acceptable_responses.each do |acceptable_response|
    #   # acceptable_response.update_attributes({:importance => params[:all_acceptable_response][:importance]})
    #   acceptable_response.update_attributes({:user_id => current_user.id, :importance => params[:all_acceptable_response][:importance], :question_id => params[:question_id]})
    # end
    # acceptable_response_values.each do |acceptable_response_value|
    #   acceptable_response_value[:importance] = params[:all_acceptable_response][:importance]
    #   acceptable_response_value[:question_id] = params[:all_acceptable_response][:question_id]
    # end


    # params[:acceptable_response].values.each do |acceptable_response|
    #   acceptable_response[:importance] = params[:all_acceptable_response][:importance]
    #   acceptable_response[:question_id] = params[:all_acceptable_response][:question_id]
    #
    #   fail
    # end

#    @acceptable_responses = current_user.acceptable_responses.new(params[:acceptable_response].values)

 #   @acceptable_responses.each do |acceptable_response|
  #    acceptable_response.save!
   # end





    #@acceptable_responses = current_user.acceptable_responses.new(params[:acceptable])
    #the ids thing that was present in our gist app
    #

    #transaction

    # accepts_nested_attributes_for :gist_files, :reject_if => :all_blank


         # has_many :responses,
         # foreign_key: :user_id
         #
         # has_many :acceptable_responses,

    #params[:question_id]

    #redirect_to profiles_url
  end

  # create_table "responses", :force => true do |t|
  #   t.integer  "user_id"
  #   t.integer  "answer_choice_id"
    #
    # class AcceptableResponse < ActiveRecord::Base
    #   attr_accessible :answer_choice_id, :importance, :user_id, :question_id


  # <form action="<%= question_answer_url(@question) %>" method="post">
  #   <%= auth_token_input %>
  #   <% qQuestion.answer_choices.each do |answer_choice| %>
  #   <label><input type="radio" name="response[answer_choice_id]" id="answer_answer_choice_id" value="<%= answer_choice.id %>"><%= answer_choice.text %></label><br>
  #   <!-- need to add user_id and question_id -->
  #   <% end %>
  #   <br>
  #   What you prefer on match:
  #   <br>
  #   <% @Question.answer_choices.each do |answer_choice| %>
  #   <input type="checkbox" name="acceptable_response[answer_choice_ids][]" value="<%= answer_choice.id %>"><%= answer_choice.text%></label><br>
  #
  #   <% end %>
  #
  #   <br>
  #   How important is this to you?
  #   <br>
  #
  #   <label><input type="radio" name="acceptable_response[importance]" value="0">Irrelevant</label><br>
  #   <label><input type="radio" name="acceptable_response[importance]" value="1">A little important</label><br>
  #   <label><input type="radio" name="acceptable_response[importance]" value="10">Important</label><br>
  #   <label><input type="radio" name="acceptable_response[importance]" value="50">Very important</label><br>
  #   <label><input type="radio" name="acceptable_response[importance]" value="250">Mandatory</label><br>
  #
  #   <input type="Submit" value="Answer question">
  #   </form>
  #


  def create

  end

end
