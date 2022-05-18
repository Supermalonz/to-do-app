FactoryBot.define do
  factory :task do
    user
    title { 'test1' }
    body { 'Lorem Lorem Lorem' }
    status { :todo }

    trait :status_done do
      status { :done }
    end

    trait :status_doing do
      status { :doing }
    end
  end
end
