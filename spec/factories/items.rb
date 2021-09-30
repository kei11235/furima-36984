FactoryBot.define do
  factory :item do

    name               {Faker::Lorem.characters(number: 10)}
    explain            {Faker::Lorem.sentence(word_count: 5)}
    category_id        {Faker::Number.between(from: 2, to: 3)}
    status_id          {Faker::Number.between(from: 2, to: 3)}
    shopping_charge_id {Faker::Number.between(from: 2, to: 3)}
    area_id            {Faker::Number.between(from: 2, to: 3)}
    days_id            {Faker::Number.between(from: 2, to: 3)}
    price              {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/image.png'),filename: 'test_image.png')
    end
  end
end
