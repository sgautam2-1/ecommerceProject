# db/migrate/xxxxxx_add_shipped_to_orders.rb
class AddShippedToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipped, :boolean, default: false
  end
end
