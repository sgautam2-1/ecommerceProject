ActiveAdmin.register Address do
  permit_params :line1, :line2, :city, :state, :country, :zipcode, :user_id, :province_id

  index do
    selectable_column
    id_column
    column :line1
    column :line2
    column :city
    column :state
    column :country
    column :zipcode
    column :user
    column :province
    actions
  end

  form do |f|
    f.inputs do
      f.input :line1
      f.input :line2
      f.input :city
      f.input :state
      f.input :country
      f.input :zipcode
      f.input :user
      f.input :province
    end
    f.actions
  end
end
