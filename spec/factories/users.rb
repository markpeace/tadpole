# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
	f.sequence(:email) { |n| "mark#{n}@learnsomestuff.com" }
	f.password "testpass01"
	f.password_confirmation "testpass01"
  end
end