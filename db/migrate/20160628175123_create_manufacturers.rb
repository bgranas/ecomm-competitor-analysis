class CreateManufacturers < ActiveRecord::Migration
  def up
    create_table :manufacturers do |t|
    	t.string :name
      t.timestamps null: false
    end
  end

  def down
  	drop_table :manufacturers
  end
end
