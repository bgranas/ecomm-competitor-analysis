class CreateStoreAllProductsUrls < ActiveRecord::Migration
  def up
    create_table :store_all_products_urls do |t|
    	t.references :store
    	t.string :all_product_url
      t.timestamps null: false
    end
  end

  def down
  	drop_table :store_all_products_urls
  end
end
