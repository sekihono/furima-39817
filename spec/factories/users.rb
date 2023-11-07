FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '鈴木' }
    first_name            { '一郎' }
    # last_name             {Faker::Name.last_name }
    # first_name            {Faker::Name.first_name }
    last_name_kana        { 'スズキ' }
    first_name_kana       { 'イチロウ' }
    # last_name_kana       { person.last.katakana }
    # first_name_kana      { person.first.katakana }
    # last_name_kana        {Faker::Japanese::Name.last_name_kana }
    # first_name_kana       {Faker::Japanese::Name.first_name_kana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
