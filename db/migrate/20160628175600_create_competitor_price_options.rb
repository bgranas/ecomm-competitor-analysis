class CreateCompetitorPriceOptions < ActiveRecord::Migration
  def up
    create_table :competitor_price_options do |t|
    	t.references :competitor_price
    	t.string :header
    	t.string :title
    	t.string :price
      t.timestamps null: false
    end
  end

  def down
  	drop_table :competitor_price_options
  end
end
