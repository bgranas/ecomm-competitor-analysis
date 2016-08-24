class CreateStoreGroups < ActiveRecord::Migration
  def up
    create_table :store_groups do |t|
    	t.references :group
    	t.references :store
      t.timestamps null: false
    end
  end

  def down
  	drop_table :store_groups
  end
end
