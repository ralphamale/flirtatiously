# Concept
Ralph-Date is OKCupid meets Tinder.

Users answer questions by providing the following: 1) Their response 2) How they would like others to answer and 3) how important the question is to them. Match percentages are then produced.

Users can also browse profiles Tinder-style, where users "Like" or "Dislike" profiles one-by-one. If two users like each other, they are notified!

#Features

-This OKCupid and Tinder hybrid clone calculates match percentages between users by examining 1) the user's answers to personality questions 2) how the user would like others to answer and 3) how important the question is to the user
-Hand-built AJAX photo uploader
-Hand-built search filter to narrow down Browse page, Tinder matches, and "Users Near You"
-Notification system to inform users when they are being messaged or if they have a mutual like
-UJS and AJAX to edit profiles, post status messages, message in-profile and in-conversation, and answer question for more responsiveness

Other notable:
-Hand-built authentication with BCrypt
-Omniauth for Facebook (pending)
-Scrollbar fixed when scrolling down too much from browse or show profile.

#Technologies
Ruby on Rails, JavaScript, UJS / AJAX, Omniauth, Geocoder

# TODO

## Very Important
  -Fix the multiple choices in profile.

  -Guest accounts that self-destruct
    -Have stuff already filled out. And say it's in-line editing.
    -Demo pictures with Flickr creative commons
    -Make Demo walkthrough
    -Have set notifications.
    -Have some people message!
    -Tips around app to guide the user through app to make implemented features extra obvious.
    -Explain how Tinder works.
  -Fix Search Bar
    -user filter "NULL" should make sure it clears the db col.
  -Seed Data with real-life data.
    -Status messages
    -Add real questions

  -Model Tests
  -Check the font for pagination.
  -Pingdom
  -RSpec Tests for models (look @ link)
  -Fix Notifications offset from bar.
  -Is a new profile off center?
  -Organized JS
  -Show all users if no users fit criteria.
  -Clear extra prompt for now.
  -Delete extra conrtoller actions.
  -Inclusion validations through model, etc.
  -Validations on search. DOes not save bad ones.
  -Validations on profile fields.
  -Validations on username
  dependent:destory on porfile, detail, photo, response
  -Delete unused profile tags.
  -Refactor: get responses, get acceptable responses, calculate percentages, find by credentials
  -Delete messages

## Important
  -"Complete registration" for those who log in with Facebook
  -Fix box in messaging so it takes up full %.
  -Nav bar photos for show profile, be uniform
  -X button to delete photos.
  -Datepicker for in-line profile editing.
  -Have more visual feedback for when postign message / status message. Have the box change.
  -Have delete button for profile.
  -Pretty print for time stamps.

## Minor
  -Bolder root page
  -Settings icon
  -Match screen!
  -Action Mailer?
  -Hover action for input, button, links
  -Format notifications thing.
  -Add sentences to help guide user through app.
  -Key bindings


### Double check
  -Visual actions for save, befriend, delete, modify, etc.
  -Add flash knowledges to acknolwedge saves, etc.
  -Is everything styled?


# FUTURE TODO
  -Refactor everything.
  -Infinite scroll
  -If you go to page again and profile likes you, it should say soemthing.
  -Is everything styled uniformly?
  -Coax you to answer question in-line if you're looking at a question you haven't answered.

  -Refactor the graphics that show up and not.
  -Push everything to organized JS instead of floating it around.
  -Do I have test coverage for all my models?
  -Are my Ruby methods in the right place? (not too long controller actions, so can put things in model)
  -"Users I have liked"
  -Snags Facebook photo for main photo.
  -"To/From" represented by sprite in messages
  -Better form errors.
  Cant message or like self!
  -Add sprite to "Submitting" and "Submitted"
  Flash/messages to add:
  No more matches for Tinder..
  No one matches your criteria
  Error with beginning age/end age.
  You have no messages.
  "No more questions."
  "You guys both like each other!"


