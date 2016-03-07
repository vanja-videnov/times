FactoryGirl.define do
  factory :comment do
    body 'This is my body'
    post_id 2
    user_id 3
  end

  factory :comment2, class: Comment do
    body 'This is my body2'
    post_id 2
    user_id 3
  end
end