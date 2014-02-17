@acceptable_responses = Response.find_by_sql ["

SELECT questions.id AS question_id, questions.text AS question_text, answer_choices.text AS answer_text
FROM questions INNER JOIN acceptable_responses
ON acceptable_responses.question_id = questions.id
INNER JOIN answer_choices
ON responses.answer_choice_id = answer_choices.id
WHERE responses.user_id = ?


              ", 1]

