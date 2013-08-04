# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :step do
    user_id 1
    brew_id 1
    title "MyString"
    days 1
    order 1
    date "2013-08-04"
    completed false
    update_inventory false
  end
end
