class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.belongs_to :category, index: true
      t.string :title
      t.text :content
      t.string :image
      t.string :reff_link
      t.timestamps
    end
  end
end
