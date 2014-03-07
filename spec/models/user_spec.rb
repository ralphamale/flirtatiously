require 'spec_helper'

describe User do
  describe "Validations" do
    it { should validate_uniqueness_of(:username) }
  end

  describe "Associations" do
    it { should have_one(:profile) }
    it { should have_many(:status_messages) }
    it { should have_many(:photos) }
    it { should have_many(:received_notifications) }
    it { should have_many(:triggered_notifications) }
    it { should have_many(:message_headers) }
    it { should have_many(:other_message_headers) }
    it { should have_many(:messages) }
    it { should have_many(:sent_ratings) }
    it { should have_many(:received_ratings) }
    it { should have_one(:user_filter) }
    it { should have_many(:responses) }
    it { should have_many(:acceptable_responses) }
    it { should have_many(:answered_questions) }
  end

  it "should calculate match percentages correctly"

  it "should find new notifications correctly"

  it "should not confuse new notifications for old notifications"

  pending "should test login features like not storing password"
end