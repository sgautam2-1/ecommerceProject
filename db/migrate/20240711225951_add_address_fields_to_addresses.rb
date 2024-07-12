# db/migrate/20240711225951_add_address_fields_to_addresses.rb
class AddAddressFieldsToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :line1, :string unless column_exists? :addresses, :line1
    add_column :addresses, :line2, :string unless column_exists? :addresses, :line2
    add_column :addresses, :city, :string unless column_exists? :addresses, :city
    add_column :addresses, :state, :string unless column_exists? :addresses, :state
    add_column :addresses, :country, :string unless column_exists? :addresses, :country
    add_column :addresses, :zipcode, :string unless column_exists? :addresses, :zipcode
  end
end
