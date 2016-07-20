class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	#t.references :manufacturer
    	t.string :title
      t.timestamps null: false
    end
  end
end
