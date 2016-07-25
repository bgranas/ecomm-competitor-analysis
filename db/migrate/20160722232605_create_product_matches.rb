class CreateProductMatches < ActiveRecord::Migration
  def change
    create_table :product_matches do |t|
    	t.integer :reference_competitor_price
    	t.integer :match_competitor_price
      t.timestamps null: false
    end
  end
end
