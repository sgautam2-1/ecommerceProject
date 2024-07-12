# db/migrate/xxxxxx_add_address_and_province_to_orders.rb
class AddAddressAndProvinceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :address, null: false, foreign_key: true
    add_reference :orders, :province, null: false, foreign_key: true
  end
end
