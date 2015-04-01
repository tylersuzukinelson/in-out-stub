FactoryGirl.define do

  factory :team do
    sequence(:name){ |n| "team_#{n}" }
  end

end
