class Shipping < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :origin_region,class_name: 'OriginRegion'
  belongs_to :payment_profile

  validates :origin_region_id , numericality: { other_than: 1 , message: "can't be blank"}

end
