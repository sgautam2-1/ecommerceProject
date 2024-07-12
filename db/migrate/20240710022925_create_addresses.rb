class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.references :province, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end