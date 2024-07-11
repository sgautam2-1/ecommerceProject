class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :gst
      t.decimal :pst
      t.decimal :qst
      t.decimal :hst

      t.timestamps
    end
  end
end
