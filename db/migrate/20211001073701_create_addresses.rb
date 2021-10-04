class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string     :postal_code,    null: false
      t.integer    :area_id,        null: false
      t.string     :municipalities
      t.string     :address,        null: false
      t.string     :building,       null: false
      t.string     :phone_num,      null: false
      t.references :order,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
