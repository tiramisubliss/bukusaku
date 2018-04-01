class DeleteStatus < ActiveRecord::Migration[5.1]
  def change
  	remove_column :categories, :status, :string
  end
end
