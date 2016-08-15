class CreateRawProducts < ActiveRecord::Migration
  def up
    create_table :raw_products do |t|
    	t.references :store
    	t.string :url
    	t.decimal :sale_price
    	t.decimal :original_price
    	t.integer :stock
    	t.string :discount
    	t.boolean :free_shipping, null: false, default: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :raw_products
  end
end
