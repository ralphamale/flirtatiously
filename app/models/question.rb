# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  category   :string(255)
#  text       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  attr_accessible :category, :text
  validates :text, presence: true
  
  has_many :answer_choices,
  foreign_key: :question_id
  
  # def index
  #   
  # end
  # 
  # 
  # def new
  #   
  # end
  # 
  # def create
  #   
  # end
  
  # def edit
  #   
  # end
  # 
  # def update
  #   
  # end
  # 
  # def destroy
  #   
  # end
  
  def show
    @question = Question.find(params[:id])
    
    
  end
  
  def answer
    
  end
  
  
end
