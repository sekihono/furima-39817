class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :product_name,     null: false
      t.text :description,        null: false
      t.string :category_id,      null: false
      t.string :product_status_id,null: false
      t.string :shipping_cost_burden_id,null: false
      t.string :origin_region_id, null: false
      t.string :delivery_time_id, null: false
      t.integer :price,null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
