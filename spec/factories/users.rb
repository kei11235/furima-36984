FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(min_length: 6, min_alpha: 1, min_numeric: 1)}
    password              {password}
    password_confirmation {password}
    nickname              {Faker::Name.initials}
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_kana        { person.last.katakana }
    first_name_kana       { person.first.katakana }
    date                  { Faker::Date.between(from: '1930-01-01', to: 5.year.ago) }
  end
end