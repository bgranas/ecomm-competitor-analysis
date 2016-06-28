class CreateJkPhotos < ActiveRecord::Migration
  def up
    create_table :jk_photos do |t|
    	t.references :jk_product
    	t.string :photo_url
      t.timestamps null: false
    end
  end

  def down
  	drop_table :jk_photos
  end
end
