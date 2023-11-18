FactoryBot.define do
  factory :item do    
    product_name          { '燕岳' }
    description           { '素敵な山の写真です。' }
    category_id           { 5 }
    product_status_id     { 3 }
    shipping_cost_burden_id  { 3 }
    origin_region_id      { 2 }
    delivery_time_id      { 3 }
    price                 { 777 }
    user                 { create(:user) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
