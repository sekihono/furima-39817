class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :product_name,     null: false
      t.text :description,        null: false
      t.integer :category_id,      null: false
      t.integer :product_status_id,null: false
      t.integer :shipping_cost_burden_id,null: false
      t.integer :origin_region_id, null: false
      t.integer :delivery_time_id, null: false
      t.integer :price,null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
