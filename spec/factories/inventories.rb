# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory do
    user_id 1
    label "MyText"
    grams 1
  end
end
