## users テーブル

| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| email              | string | null: false, uniqueness: true |
| encrypted_password | string | null: false                   |
| nickname           | string | null: false                   |
| last_name          | string | null: false                   |
| first_name         | string | null: false                   |
| last_name_kana     | string | null: false                   |
| first_name_kana    | string | null: false                   |
| date               | date   | null: false                   |

### Association
- has_many :items
- has_many :orders

## items テーブル

| Column             | Type      | Options                        |
| ------------------ | --------- | ------------------------------ |
| name               | string    | null: false                    |
| explain            | text      | null: false                    |
| category_id        | int       | null: false                    |
| status_id          | int       | null: false                    |
| shopping_charge_id | int       | null: false                    |
| area_id            | int       | null: false                    |
| days_id            | int       | null: false                    |
| price              | int       | null: false                    |
| user               |references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## order テーブル

| Column          | Type      | Options                        |
| --------------- | --------- | ------------------------------ |
| user            |references | null: false, foreign_key: true |
| item            |references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column         | Type      | Options                        |
| -------------- | --------- | ------------------------------ |
| postal_code    | string    | null: false                    |
| prefectures    | string    | null: false                    |
| municipalities | string    | null: false                    |
| address        | string    | null: false                    |
| building       | string    |                                |
| phone_num      | string    | null: false                    |
| order          |references | null: false, foreign_key: true |

### Association
- belongs_to :order