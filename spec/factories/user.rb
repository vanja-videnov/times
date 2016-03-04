FactoryGirl.define do
  factory :sanja, class: User do
    email "vaca@rbt.com"
    password "1234rtg"
    phone "1234567890"
  end


  # factory :user do
  #   sequence(:email) { |n| "user#{n}@example.com" }
  #   password "1234rtg"
  #   phone "1234567890"
  # end
  #
  # factory :sanja, parent: :user do
  #   email 'vaca@rbt.rs'
  # end
end