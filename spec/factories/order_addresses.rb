FactoryBot.define do
  factory :order_address do
    postal_code {"123-4567"}
    area_id { Faker::Number.between(from: 2, to: 48) }
    municipalities { Gimei.city.kanji }
    address { Gimei.town.kanji }
    building { "建物名" }
    phone_num {"0123456789"}
    token {"tok_abcdefghijk00000000000000000"}
  end
end
