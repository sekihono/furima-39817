class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string  :postal_code,   null: false
      t.integer :origin_region_id, null: false
      t.string  :city,          null: false
      t.string  :street_number, null: false
      t.string  :building_name, null: true
      t.integer :phone_number,  null: false
      t.references :payment_profile, null: false, foreign_key: true
      t.timestamps
    end
  end
end
