ActiveAdmin.register Order do
  permit_params :status, :total_amount, :shipped

  index do
    selectable_column
    id_column
    column :user
    column :address
    column :province
    column :status
    column :total_amount
    column :shipped
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :status
      f.input :shipped, as: :boolean
    end
    f.actions
  end
end
