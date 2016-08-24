class CreateStoreScrapeTerms < ActiveRecord::Migration
  def up
    create_table :store_scrape_terms do |t|
    	t.references :store
      t.string :all_products
    	t.string :product_title
    	t.string :sale_price
    	t.string :original_price
    	t.string :shipping
    	t.string :stock
    	t.string :discount
      t.string :option_container
    	t.string :option_title
    	t.string :option_price
      t.timestamps null: false
    end
  end

  def down
  	drop_table :store_scrape_terms
  end
end
