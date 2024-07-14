# app/admin/orders.rb
ActiveAdmin.register Order do
  permit_params :status, :total_amount, :shipped, order_items_attributes: [:product_id, :quantity, :price]

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :total_amount
    column :shipped
    column :created_at
    actions
  end

  filter :user
  filter :status
  filter :total_amount
  filter :shipped

  form do |f|
    f.inputs 'Order Details' do
      f.input :status
      f.input :total_amount
      f.input :shipped
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :status
      row :total_amount
      row :shipped
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
      end
    end
  end
end
