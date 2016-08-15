class CreateStores < ActiveRecord::Migration
  def up
    create_table :stores do |t|
    	enable_extension "hstore"
      t.string :name
      t.string :home_url
    	t.string :all_products_url
    	t.string :ecomm_platform
      t.hstore :fuzzy_match_stop_words, index: true
      t.timestamps null: false
    end
  end

  def down
  	drop_table :stores
  end
end
