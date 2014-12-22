class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :pid
      t.string :url
      t.integer :store_id
      t.string :isbn
      t.string :isbn10
      t.boolean :active

      t.timestamps
    end
  end
end
