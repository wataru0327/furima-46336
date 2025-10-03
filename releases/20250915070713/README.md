# データベース設計

## users テーブル
| Column             | Type   | Options                        |
|--------------------|--------|--------------------------------|
| nickname           | string | null: false                    |
| email              | string | null: false, unique: true      |
| encrypted_password | string | null: false                    |
| last_name          | string | null: false                    |
| first_name         | string | null: false                    |
| last_name_kana     | string | null: false                    |
| first_name_kana    | string | null: false                    |
| birthday           | date   | null: false                    |

### Association
- has_many :items
- has_many :orders


## items テーブル
| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| name                | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    | <!-- ActiveHash -->
| condition_id        | integer    | null: false                    | <!-- ActiveHash -->
| shipping_charge_id  | integer    | null: false                    | <!-- ActiveHash -->
| prefecture_id       | integer    | null: false                    | <!-- ActiveHash -->
| days_to_ship_id     | integer    | null: false                    | <!-- ActiveHash -->
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order


## orders テーブル
| Column   | Type       | Options                        |
|----------|------------|--------------------------------|
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## shipping_addresses テーブル
| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    | <!-- ActiveHash -->
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association
- belongs_to :order