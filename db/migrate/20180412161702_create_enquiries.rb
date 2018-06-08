class CreateEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :enquiries do |t|
      t.belongs_to :product, index: true
      t.string :name
      t.string :phone_number
      t.string :job
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
