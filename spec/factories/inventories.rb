# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inventory do
    association :user, :factory=>:user
    label "MyText"
    grams 1
  end
end
