FactoryGirl.define do
  factory :admin, class: User do
    username "admin"
    password "password"
    admin true
    api_secret MicroToken.generate(128)
  end

  factory :gem, class: Product do
    name "Ruby"
    price 3
  end
end
