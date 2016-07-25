class CreateCompetitorScrapeTerms < ActiveRecord::Migration
  def up
    create_table :competitor_scrape_terms do |t|
    	t.references :competitor
    	t.string :title
    	t.string :sale_price
    	t.string :original_price
    	t.string :free_shipping
    	t.string :stock
    	t.string :discount
    	t.string :option_title
    	t.string :option_price
      t.timestamps null: false
    end
  end

  def down
  	drop_table :competitor_scrape_terms
  end
end
