class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :product_id
      t.float :price
      t.float :price_new
      t.float :price_used

      t.timestamps
    end
  end
end
