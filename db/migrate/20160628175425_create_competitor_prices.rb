class CreateCompetitorPrices < ActiveRecord::Migration
  def change
    create_table :competitor_prices do |t|
    	t.references :product
    	t.references :competitor
    	t.string :url
    	t.decimal :sale_price
    	t.decimal :original_price
    	t.integer :stock
    	t.string :discount
    	t.boolean :free_shipping, null: false, default: false
      t.timestamps null: false
    end
  end
end
