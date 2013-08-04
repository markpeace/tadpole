# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brew do
	association :user, :factory=>:user
    name "lenticular"
    date "2014-01-01"
  end
end
