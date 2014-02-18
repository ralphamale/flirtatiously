# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)





["Do you have low self esteem?",
  "Do you moisturize your hands?",
  "Will you do anal?",
  "Are you a loser?"].each do |question_text|

    q = Question.create({text: question_text})
    AnswerChoice.create([{question_id: q.id, text: "Yes"}, {question_id: q.id, text: "No"}, {question_id: q.id, text: "Not by choice"}])
  end


  rafsgirl = User.create({username: "rafsgirl", password: "password"})

  #
