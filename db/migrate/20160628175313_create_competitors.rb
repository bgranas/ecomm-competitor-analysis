class CreateCompetitors < ActiveRecord::Migration
  def up
    create_table :competitors do |t|
    	t.string :name
    	t.string :home_url
    	t.string :all_products_url
    	t.string :ecomm_platform
      t.timestamps null: false
    end
  end

  def down
  	drop_table :competitors
  end
end
