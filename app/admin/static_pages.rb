# app/admin/static_pages.rb
ActiveAdmin.register StaticPage do
  permit_params :title, :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :quill_editor
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  filter :title
end
