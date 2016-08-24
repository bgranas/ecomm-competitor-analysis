class CreateRawProducts < ActiveRecord::Migration
  def up
    create_table :raw_products do |t|
    	t.references :store
    	t.string :url
      t.string :product_title
    	t.decimal :sale_price
    	t.decimal :original_price
    	t.integer :stock
    	t.string :discount
    	t.decimal :shipping
      t.timestamps null: false
    end
  end

  def down
    drop_table :raw_products
  end
end
