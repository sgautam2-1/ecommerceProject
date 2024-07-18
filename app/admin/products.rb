# app/admin/products.rb

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :image_url

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category
    column :image_url
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :image_url
    end
    f.actions
  end
end
