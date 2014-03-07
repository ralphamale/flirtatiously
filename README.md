This README is under construction.

[See Flirtatiously deployed.]: http://ralph-date.herokuapp.com/

# Concept

Flirtatiously is OKCupid meets Tinder.

Users answer questions by providing the following: 1) Their response 2) How they would like others to answer and 3) how important the question is to them. Match percentages are then produced.

Users can also browse profiles Tinder-style, where users "Like" or "Dislike" profiles one-by-one. If two users like each other, they are notified!

#Features

* This OKCupid and Tinder hybrid clone calculates match percentages between users by examining 1) the user's answers to personality questions 2) how the user would like others to answer and 3) how important the question is to the user
* Hand-built AJAX photo uploader
* Hand-built search filter to narrow down Browse page, Tinder matches, and "Users Near You"
* Notification system to inform users when they are being messaged or if they have a mutual like
* UJS and AJAX to edit profiles, post status messages, message in-profile and in-conversation, and answer question for more responsiveness

Other notable:
* Hand-built authentication with BCrypt
* Scrollbar fixed when scrolling down too much from browse or show profile.
* Secondary navbar is stickified for browse and show pages.

#Technologies
Ruby on Rails, JavaScript, UJS / AJAX, Omniauth, Geocoder

# Model Tests
Tests associations, validations, and model methods

# Capybara Features to Test
## Need to implement after model tests

* Account creation
* Account sign in
* Posting a new status message

* Messages
  * Correctly shows who sent
  * Can delete message

* Questions
  * Popup open/close
  * After answering question, should appear in "Questions"

Browse Profiles
  * User filter changes browse page

* Conversations
  * Posting a new message

* Profile show page (viewing other users)
  * Messaging a user
  * Liking a user
  * Disliking a user

* Profile show page (self)
  * Should not have message/like/dislike button
  * Can edit biography
  * Can edit select fields.
  * Can upload profile photo that persists.

# TODO
* Add Capybara tests.
* Finish Model tests
* Fix the multiple choices in profile.
* Set up Pingdom

* Key bindings for "Like", "Dislike", and "Message"

* Organize JS

* Refactor: get responses, get acceptable responses, calculate percentages, find by credentials


### Double check
* Make sure everything is styled uniformly.
* Delete routes and controller actions that are no longer needed. Delete all files flagged.
* Delete profile attributes that are old.

# Features to Add in Future

* Allows you to answer a question in-line when you are viewing someone else's profile.
* Push everything to organized JS instead of floating it around.
* Move controller actions to model if appropriate.

