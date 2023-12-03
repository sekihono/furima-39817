FactoryBot.define do
  factory :payment_profiles_shippings do
    postal_code           { '182-0015' }
    origin_region_id      { 2 }
    city                  { '武蔵野市関町' }
    street_number         { '1-23-45' }
    building_name         { 'クリスタルビル9F' }
    phone_number          { '0422436621' }
    token                 { SecureRandom.hex(10) }
  end
end
