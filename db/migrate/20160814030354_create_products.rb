class CreateProducts < ActiveRecord::Migration
  def up
    create_table :products do |t|
    	t.references :manufacturer
    	t.string :title
    	t.string :upc
    	t.integer :weight
      t.timestamps null: false
    end
  end

  def down
  	drop_table :products
  end
end
