FactoryGirl.define do
  factory :sanja, class: User do
    email "vaca@rbt.com"
    password "1234rtg"
    phone "1234567890"
    admin true

    factory :not_admin do
      email "vanja@rbttt.com"
      password "12345rfvg"
      admin false
    end
  end


  # factory :marija, class: User do
  #   email "vanja@rbttt.com"
  #   password "12345rfvg"
  #   phone "0643335504"
  #   name "Vanja"
  #   admin 'false'
  # end

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