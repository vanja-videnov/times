FactoryGirl.define do
  factory :post do
    id 1
    title "My new title"
    body "My new body"
    user_id 3

  end

  factory :post2, class: Post do

    id 2
    title "My new title"
    body "My new body"
    user_id 2

  end


  end