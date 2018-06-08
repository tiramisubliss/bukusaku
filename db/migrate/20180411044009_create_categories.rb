class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category_name
      t.string :hex_color
      t.string :icon
      t.timestamps
    end
  end
end
