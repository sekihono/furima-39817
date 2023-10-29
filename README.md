# テーブル設計

## users テーブル 

| Column             | Type   | Options      |
| ------------------ | ------ | ------------ |
| nickname           | string | null: false  |
| email              | string | unique: true |
| encrypted_password | string | null: false  |
| last_name          | string | null: false  |
| first_name         | string | null: false  |
| last_name_kana     | string | null: false  |
| first_name_kana    | string | null: false  |
| birthday           | date   | null: false  |


### Association 

- has_many :items
- has_many :payment_profiles


## items テーブル 

| Column                  | Type       | Options                       |
| ----------------------- | ---------- | ----------------------------- |
| product_name            | string     | null: false                   |
| description             | text       | null: false                   |
| category_id             | integer    | null: false                   |
| product_status_id       | integer    | null: false                   |
| shipping_cost_burden_id | integer    | null: false                   |
| origin_region_id        | integer    | null: false                   |
| delivery_time_id        | integer    | null: false                   |
| price                   | string     | null: false                   |
| user                    | references | null: false foreign_key: true |

### Association 

- belongs_to :user
- has_one    :payment_profile


## payment_profilesテーブル 

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :item
- has_one    :shipping


##  Shippingsテーブル 

| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| postal_code      | string     | null: false                   |
| prefecture_id    | integer    | null: false                   |
| city             | string     | null: false                   |
| street_number    | string     | null: false                   |
| building_name    | string     |                               |
| phone_number     | string     | null: false                   |
| payment_profile  | references | null: false foreign_key: true |

### Association 

- belongs_to :payment_profile

