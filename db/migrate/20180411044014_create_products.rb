class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.belongs_to :category, index: true
      t.string :product_name
      t.string :company
      t.text   :description
      t.string :logo_img
      t.string :web_link
      t.string :gplay_link
      t.timestamps
    end
  end
end
