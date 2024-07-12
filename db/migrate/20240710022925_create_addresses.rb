# db/migrate/20240710022925_create_addresses.rb
class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :street_address
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
