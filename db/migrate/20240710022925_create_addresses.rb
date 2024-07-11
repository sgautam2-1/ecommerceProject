class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.references :province, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
