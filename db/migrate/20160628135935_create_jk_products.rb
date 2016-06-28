class CreateJkProducts < ActiveRecord::Migration
  def up
    create_table :jk_products do |t|
    	t.string :url
    	t.string :title
    	t.decimal :price
    	t.text :description
    	t.string :model
    	t.string :interior_dimension
    	t.string :exterior_dimension
    	t.string :max_temp
    	t.string :volts
    	t.string :amps
    	t.string :watts
    	t.string :plug
    	t.string :breaker
    	t.string :wire_gauge
    	t.integer :prod_weight
    	t.integer :ship_weight
      t.timestamps null: false
    end
  end

  def down
  	drop_table :jk_products
  end
end
