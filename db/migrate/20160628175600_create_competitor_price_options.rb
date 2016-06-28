class CreateCompetitorPriceOptions < ActiveRecord::Migration
  def change
    create_table :competitor_price_options do |t|
    	t.references :competitor_price
    	t.string :name
    	t.string :price
      t.timestamps null: false
    end
  end
end
