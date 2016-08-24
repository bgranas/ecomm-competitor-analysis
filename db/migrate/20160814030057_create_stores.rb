class CreateStores < ActiveRecord::Migration
  def up
    create_table :stores do |t|
      t.string :name
      t.string :home_url
    	t.string :ecomm_platform
      t.timestamps null: false
    end
  end

  def down
  	drop_table :stores
  end
end
