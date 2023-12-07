class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_status,class_name: 'ProductStatus'
  belongs_to :shipping_cost_burden,class_name: 'ShippingCostBurden'
  belongs_to :origin_region,class_name: 'OriginRegion'
  belongs_to :delivery_time,class_name: 'DeliveryTime'

  belongs_to :user

  has_one_attached :image
  has_one :payment_profile

  def sold_out?
    payment_profile.present? && !payment_profile.nil?
  end

  validates :image, presence: true
  validates :product_name, presence: true
  validates :description , presence: true
  validates :category_id , presence: true
  validates :product_status_id, presence: true
  validates :shipping_cost_burden_id, presence: true
  validates :origin_region_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  validates :category_id      , numericality: { other_than: 1 , message: "can't be blank"}
  validates :product_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_cost_burden_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :origin_region_id , numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_time_id , numericality: { other_than: 1 , message: "can't be blank"}
end
