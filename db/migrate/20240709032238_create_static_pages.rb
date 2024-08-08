class CreateStaticPages < ActiveRecord::Migration[6.1]
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :content
      t.string :slug, unique: true

      t.timestamps
    end

    add_index :static_pages, :slug, unique: true
  end
end
