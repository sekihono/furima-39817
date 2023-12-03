class PaymentProfilesShippings
  include ActiveModel::Model
  attr_accessor  :item_id, :user_id, :postal_code, :origin_region_id, :city, :street_number, :building_name, :phone_number, :payment_profile_id, :token, :price

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}

    validates :city
    validates :street_number
    validates :phone_number, presence: true, numericality: { only_integer: true },length: { minimum: 10, maximum: 11 }
    validates :item_id
    validates :user_id
    validates :building_name, allow_blank: true
    validates :token

  end
  validate :origin_region_id_presence
  validates :origin_region_id, numericality: { other_than: 1, message: "can't be blank" }

  def origin_region_id_presence
    if (origin_region_id.nil? || origin_region_id == 1)
      errors.add(:origin_region_id, "can't be blank")
    else
      errors.delete(:origin_region_id)  
    end
  end
  
  
  def save
    payment_profile = PaymentProfile.create(item_id: item_id, user_id: user_id)
    Shipping.create(
      postal_code: postal_code,
      origin_region_id: origin_region_id,
      city: city,
      street_number: street_number,
      building_name: building_name,
      phone_number: phone_number,
      payment_profile_id: payment_profile.id
    )
  end

end