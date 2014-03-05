#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require File.dirname(__FILE__) + '/../config/initializers/constants'
#was generated from before?

male_usernames = ["jFire", "MyTiesAreSkinny", "luv2gym5", "cookiemonster5"]

female_usernames = ["tshirtandjeans7", "yeahnonotreally", "spicy_soup", "gallerylove"]



male_descriptions = ["My ties are skinny. My pockets have squares.
                      Not always a complete tool, but I play one in major periodicals
                      (insert now-obligatory winking emoticon here).", "i splurge on
                      concert tickets, nice shoes, and dinners where the i let the
                      waiter order for me. this is the holy trinity...basically i
                      let everything else fall into place.", "I like new ideas and
                      being around people who are passionate and driven. I'm laid
                      back, fun to be around, and can order off of a Thai menu
                      like nobody's business.", "I've been living in New York for
                      over 2 years, and love the endless number of things to do and
                      explore here. I spend a lot of my free time hanging out with
                      friends and seeing as much live music as I can, but I try to
                      balance that with work and going to the gym regularly. I love
                      to travel, and never seem to have enough vacation days for it.
                      Overall I would say that I am a pretty grounded person, I am
                      very laid-back and it is not difficult for me to have fun."]

female_descriptions = ["I like being in relationships where you can be completely
                        goofy/weird or serious. I like to go out but also just sit
                        and have good conversation with friends. I enjoy being
                        outside, exploring restaurants and bars, and meeting new
                        people. I spend a lot of time walking around the city and
                        seeing the different areas. I really like to grab a beer
                        or a glass of wine and listen to live music. I'm into
                        liberal, easy going, open-minded, intelligent people
                        that can make me laugh. I'm always trying to improve
                        things about myself and would like to be with someone
                        who is also introspective.", "I've moved to Brooklyn
                        after circumnavigating the globe. Couchsurfed my way
                        through Europe, backpacked in the Himalayas, and ended
                        my trip wandering Burma before it's overrun with
                        tourists like me. Now I intern for a science magazine
                        in New York City. Love writing, live music, playing
                        pool, and anything in the outdoors-- hiking, backpacking,
                        swimming in the ocean, skinny dipping.", "Native Pacific
                        Northwesterner. Graduated from college, left the mean
                        streets of L.A. and moved to NY on a whim. Currently
                        working in architecture/design. Former ballet dancer.
                        Vietnamese coffee lover. Hiking & skiing & music
                        festival & travel enthusiast. Film/tv buff.", "I'm a
                        wise ass and I have an edgy, femme look and attitude.
                        I am passionate and fiesty. Toss a little moody in
                        there as well- fire signs, typical Aries, though I
                        do have a soft side as well, maybe you will be lucky
                        enough to see that ;) I like to laugh, be silly
                        and enjoy myself. When I get excited about something,
                        trust me, you will know. I strive for perfection though
                        let's be honest, is there really such a thing?"]

(0..3).each do |i|
  male_user = User.create!({username: male_usernames[i], password: "password"})
  female_user = User.create!({username: female_usernames[i], password: "password"})

  [male_user,female_user].each do |user|
    user.build_user_filter.save!

    test_profile = Profile.create!({
      user_id: user.id,
      birthday: "#{2014-18-i}-12-01",
      sexual_orientation: rand(0..2),
        zip_code: [10003, 10453,
          11204, 11206, 10023,
          10001, 11222, 12518, 14604].sample,
        body_type: rand(0..4),
        smokes: rand(0..3),
        drugs: rand(0..3),
        religion: rand(0..6),
        sex: (user == male_user) ? "M" : "F"
    })

    if male_user == user
      test_profile.update_attributes!({sex: "M", description: male_descriptions[i]})

      (1..3).each do |j|
        Photo.create!(file: File.open(File.join(::Rails.root, "/seed_images/M_#{i}_#{j}.jpeg")), profile_id: test_profile.id)
      end

    else
      test_profile.update_attributes!({sex: "F", description: female_descriptions[i]})

      (1..3).each do |j|
        Photo.create!(file: File.open(File.join(::Rails.root, "/seed_images/F_#{i}_#{j}.jpeg")), profile_id: test_profile.id)
      end
    end

  end

end


questions = {
  "Jealousy in a relationship..." => ["Healthy", "Unhealthy", "A little bit can add to the passion"],
  "Choose the better romantic activity" => ["Kissing in the woods", "Going to Paris", "Skydiving"],
  "In a relationship, I like to discuss politics with my partner" => ["Sure. I am interested in
    sharing our beliefs", "Sometimes. It depends.", "Absolutely Not"],
  "Do you like to cuddle?" => ["Yes", "No", "Once in a blue moon"],
  "How do you feel about falling in love?" => ["I love it and want it very
    much", "I try to avoid it", "I like to just let it happen", "Not sure"]
}

questions.each do |q_text, answer_choices|
  q = Question.create({text: q_text})

  answer_choices.each do |answer_text|
    AnswerChoice.create({question_id: q.id,
      text: answer_text})
  end

  User.pluck(:id).each do |user_id|
    answer_choice_ids = q
        .answer_choices
        .pluck(:id)

    Response.create!({
      answer_choice_id: answer_choice_ids.sample,
      question_id: q.id,
      user_id: user_id
    })

    question_importance =
      [0,1,10,50,250].sample

    num_acceptables =
      rand(1..answer_choice_ids.length-1)

    num_acceptables.times do
      AcceptableResponse.create!({
        answer_choice_id:
        answer_choice_ids.pop,
        importance: question_importance,
        question_id: q.id,
        user_id: user_id
      })
    end
  end
end




