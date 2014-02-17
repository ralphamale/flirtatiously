Response.find_by_sql ["

    SELECT questions.id AS question_id,
    questions.text AS question_text,
    other_user_answer_choices.text AS other_user_answer_text,
    other_user_answer_choices.id AS other_user_answer_id,
    current_user_responses.answer_choice_id AS current_user_answer_choice_id,
    current_user_responses.answer_choice_text AS current_answer

    FROM questions
    INNER JOIN responses
    AS other_user_responses
    ON other_user_responses.question_id = questions.id

    INNER JOIN answer_choices
    AS other_user_answer_choices
    ON other_user_responses.answer_choice_id = other_user_answer_choices.id

    LEFT OUTER JOIN
    (SELECT responses.question_id AS question_id, answer_choices.id AS answer_choice_id, answer_choices.text AS answer_choice_text
    FROM responses
    JOIN answer_choices
    ON responses.answer_choice_id = answer_choices.id
  WHERE responses.user_id = ?)
  AS current_user_responses ON
  other_user_responses.question_id = current_user_responses.question_id


    WHERE other_user_responses.user_id = ?


                  ", current_user.id, other_user_id]