# テーブル設計

## users テーブル 

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| birth_date         | string | null: false |


### Association 

- has_many :items
- has_many :Payment_profiles


## items テーブル 

| Column         | Type       | Options                       |
| -------------- | ---------- | ----------------------------- |
| product_name   | string     | null: false                   |
| description    | text       | null: false                   |
| product_status | string     | null: false                   |
| user           | references | null: false foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :payment_profile


## payment_profilesテーブル 

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| card_number     | string     | null: false                    |
| expiration_date | string     | null: false                    |
| security_code   | string     | null: false                    |
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- belongs_to :item
- belongs_to :shipping


##  Shippingsテーブル 

| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| postal_code      | string     | null: false                   |
| prefecture       | string     | null: false                   |
| city             | string     | null: false                   |
| street_number    | string     | null: false                   |
| building_name    | string     | null: true                    |
| payment_profiles | references | null: false foreign_key: true |

### Association 

- belongs_to :payment_profile

