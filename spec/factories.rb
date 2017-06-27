FactoryGirl.define do

  factory :club do
    name 'Augusta Country Club'
    city 'Augusta'
    state 'GA'
  end

  factory :tee do
    club
    color 'I-O Champ'
    usga_course_rating_18 73.6
    slope_rating_18 133
    front_9_rating 37.8
    front_9_slope 137
    back_9_rating 35.9
    back_9_slope 129
    bogey_rating 98.3
    gender 'M'
  end

  factory :user do
    username 'testuser'
    email 'testuser@mailinator.com'
    password 'testpass'
    password_confirmation 'testpass'
  end

end
