FactoryGirl.define do
  factory :post do

    title "My new title"
    body "My new body"

  end

  factory :post2, class: Post do

    title "title2"
    body "My new body"
  end

end