class CreateMatchExclusions < ActiveRecord::Migration
  def up
    create_table :match_exclusions do |t|
    	t.string :term
      t.timestamps null: false
    end
  end

  def down
  	drop_table :match_exclusions
  end
end
