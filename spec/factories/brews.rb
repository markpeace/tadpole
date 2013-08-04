# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brew do
	association :user, :factory=>:user
    name "Lenticular"
    date "2013-08-04"
  end
end
