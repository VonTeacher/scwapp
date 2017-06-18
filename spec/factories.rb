FactoryGirl.define do
  factory :club do
    name 'Augusta Country Club'
    city 'Augusta'
    state 'GA'
  end

  factory :tee do
    color 'I-O Champ'
    usga_course_rating_18 73.6
    slope_rating_18 133
    front_9_rating 37.8
    front_9_slope 137
    back_9_rating 35.9
    back_9_slope 129
    bogey_rating 98.3
    gender 'M'
    club_id #what goes here
  end

end
